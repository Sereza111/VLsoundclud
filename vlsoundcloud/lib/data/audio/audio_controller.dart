import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../models/sc_track.dart';
import '../soundcloud/soundcloud_providers.dart';

/// Singleton-ish facade around [AudioPlayer].
///
/// Owns the queue of [ScTrack]s, the current playback state, and the audio
/// pipeline (incl. the equalizer effect). UI talks to it strictly through
/// the Riverpod providers below — never directly.
class AudioController {
  AudioController({required this.ref}) {
    final useAndroidEq = !kIsWeb && Platform.isAndroid;
    if (useAndroidEq) {
      equalizer = AndroidEqualizer();
      _player = AudioPlayer(
        audioPipeline: AudioPipeline(androidAudioEffects: [equalizer!]),
      );
    } else {
      equalizer = null;
      _player = AudioPlayer();
    }

    _player.playbackEventStream.listen(
      (_) {},
      onError: (Object err, StackTrace st) {
        // Surface in debug; UI keeps state via streams below.
        // ignore: avoid_print
        print('AudioPlayer error: $err\n$st');
      },
    );
  }

  final Ref ref;
  late final AudioPlayer _player;

  /// Только Android (см. [AudioPipeline] + ExoPlayer). На Windows/iOS/macOS —
  /// `null`, эквалайзер в UI отключён.
  AndroidEqualizer? equalizer;

  /// Currently materialised queue (index-aligned with [_player]'s sequence).
  final List<ScTrack> _queue = [];

  AudioPlayer get player => _player;
  List<ScTrack> get queue => List.unmodifiable(_queue);

  // ---------------------------------------------------------------------------
  // Streams (consumed by Riverpod providers)
  // ---------------------------------------------------------------------------

  Stream<bool> get playingStream => _player.playingStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<ProcessingState> get processingStateStream =>
      _player.processingStateStream;
  Stream<int?> get currentIndexStream => _player.currentIndexStream;

  // ---------------------------------------------------------------------------
  // Transport
  // ---------------------------------------------------------------------------

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> seekToNext() => _player.seekToNext();
  Future<void> seekToPrevious() => _player.seekToPrevious();
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);
  Future<void> setLoopMode(LoopMode mode) => _player.setLoopMode(mode);
  Future<void> setShuffle(bool enabled) =>
      _player.setShuffleModeEnabled(enabled);

  /// Replace the queue with [tracks] and start playing from [startIndex].
  ///
  /// Stream URLs are resolved lazily on demand to avoid spamming SoundCloud.
  Future<void> setQueue(
    List<ScTrack> tracks, {
    int startIndex = 0,
    bool autoplay = true,
  }) async {
    if (tracks.isEmpty) return;

    _queue
      ..clear()
      ..addAll(tracks);

    final repo = ref.read(soundCloudRepositoryProvider);

    // Параллельно резолвим все потоки — быстрее, чем по одному await в цикле.
    final resolved = await Future.wait(
      tracks.map((t) => repo.getStream(t.id)),
    );

    final sources = <AudioSource>[];
    for (var i = 0; i < tracks.length; i++) {
      final t = tracks[i];
      final stream = resolved[i];
      sources.add(
        AudioSource.uri(
          Uri.parse(stream.url),
          tag: MediaItem(
            id: t.id,
            title: t.title,
            artist: t.author.displayName ?? t.author.username,
            duration: t.duration == Duration.zero ? null : t.duration,
            artUri: t.artworkUrl != null ? Uri.parse(t.artworkUrl!) : null,
          ),
        ),
      );
    }

    await _player.setAudioSources(sources, initialIndex: startIndex);
    if (autoplay) await _player.play();
  }

  /// Convenience: replace the queue with a single track.
  Future<void> playSingle(ScTrack track) => setQueue([track]);

  Future<void> dispose() => _player.dispose();
}

// ---------------------------------------------------------------------------
// Riverpod providers
// ---------------------------------------------------------------------------

final audioControllerProvider = Provider<AudioController>((ref) {
  final controller = AudioController(ref: ref);
  ref.onDispose(controller.dispose);
  return controller;
});

final isPlayingProvider = StreamProvider<bool>((ref) {
  return ref.watch(audioControllerProvider).playingStream;
});

final playerPositionProvider = StreamProvider<Duration>((ref) {
  return ref.watch(audioControllerProvider).positionStream;
});

final playerDurationProvider = StreamProvider<Duration?>((ref) {
  return ref.watch(audioControllerProvider).durationStream;
});

final processingStateProvider = StreamProvider<ProcessingState>((ref) {
  return ref.watch(audioControllerProvider).processingStateStream;
});

final currentIndexProvider = StreamProvider<int?>((ref) {
  return ref.watch(audioControllerProvider).currentIndexStream;
});

/// Currently active track derived from queue + index.
final currentTrackProvider = Provider<ScTrack?>((ref) {
  final controller = ref.watch(audioControllerProvider);
  final index = ref.watch(currentIndexProvider).value;
  if (index == null || index < 0 || index >= controller.queue.length) {
    return null;
  }
  return controller.queue[index];
});
