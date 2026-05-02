import 'package:http/http.dart' as http;
import 'package:soundcloud_explode_dart/soundcloud_explode_dart.dart' as sc;

import '../models/sc_playlist.dart';
import '../models/sc_stream.dart';
import '../models/sc_track.dart';
import '../models/sc_user.dart';
import 'soundcloud_http_client.dart';
import 'soundcloud_repository.dart';
import 'soundcloud_stream_resolver.dart';

/// SoundCloud data layer powered by `soundcloud_explode_dart`.
///
/// Scrapes the public web client_id and uses SoundCloud's internal v2 API.
/// Pros: zero credentials, ships immediately. Cons: lives in a grey zone of
/// the SoundCloud ToS — for production consider migrating to the OAuth-based
/// [OfficialApiRepository].
class ExplodeRepository implements SoundCloudRepository {
  ExplodeRepository._(this._http, this._client);

  /// Один [http.Client] и для пакета, и для резолвера потоков (заголовки +
  /// `track_authorization`).
  factory ExplodeRepository() {
    final httpClient = createSoundCloudHttpClient();
    return ExplodeRepository._(
      httpClient,
      sc.SoundcloudClient(httpClient: httpClient),
    );
  }

  final http.Client _http;
  final sc.SoundcloudClient _client;

  @override
  Future<List<ScTrack>> searchTracks(String query, {int limit = 25}) async {
    if (query.trim().isEmpty) return const [];
    final results = <sc.TrackSearchResult>[];
    await for (final batch in _client.search.getTracks(query, limit: limit)) {
      results.addAll(batch);
      if (results.length >= limit) break;
    }
    return results.take(limit).map(_mapTrackSearch).toList(growable: false);
  }

  @override
  Future<List<ScPlaylist>> searchPlaylists(String query,
      {int limit = 25}) async {
    if (query.trim().isEmpty) return const [];
    final results = <sc.PlaylistSearchResult>[];
    await for (final batch in _client.search.getPlaylists(query, limit: limit)) {
      results.addAll(batch);
      if (results.length >= limit) break;
    }
    return results.take(limit).map(_mapPlaylistSearch).toList(growable: false);
  }

  @override
  Future<ScTrack> getTrack(String id) async {
    final track = await _client.tracks.get(int.parse(id));
    return _mapTrack(track);
  }

  @override
  Future<ScTrack> getTrackByUrl(String url) async {
    final track = await _client.tracks.getByUrl(url);
    return _mapTrack(track);
  }

  @override
  Future<ScStream> getStream(String trackId) async {
    try {
      final streams = await _client.tracks.getStreams(int.parse(trackId));
      if (streams.isNotEmpty) {
        final pick = _pickBestStream(streams);
        return ScStream(
          url: pick.url,
          format: pick.protocol == 'hls'
              ? ScStreamFormat.hls
              : ScStreamFormat.progressive,
          mimeType: pick.protocol == 'hls'
              ? 'application/vnd.apple.mpegurl'
              : 'audio/${pick.container.isEmpty ? 'mpeg' : pick.container}',
        );
      }
    } catch (_) {
      // Ниже — резолвер с track_authorization.
    }

    final fallback =
        await SoundcloudStreamResolver(_http).resolvePlaybackUrl(trackId);
    if (fallback != null) return fallback;

    throw StateError(
      'Не удалось получить аудио-поток для трека $trackId.\n'
      'Официальное приложение SoundCloud ходит в API с авторизацией '
      '(поле track_authorization / OAuth); через открытый client_id часть '
      'треков недоступна.\n'
      'Попробуй другой трек или запуск с опциями:\n'
      '  --dart-define=SC_CLIENT_ID=… (ключ приложения soundcloud.com/you/apps)\n'
      '  --dart-define=SC_OAUTH_TOKEN=… (сессионный OAuth-токен, продвинуто)',
    );
  }

  /// Выбираем лучший доступный поток: progressive > hls, полный трек > preview,
  /// HQ > SQ.
  sc.StreamInfo _pickBestStream(List<sc.StreamInfo> streams) {
    int score(sc.StreamInfo s) {
      var v = 0;
      if (s.protocol == 'progressive') v += 100;
      if (s.protocol == 'hls') v += 50;
      if (!s.isSnipped) v += 40;
      switch (s.quality) {
        case sc.Quality.highQuality:
          v += 20;
        case sc.Quality.standardQuality:
          v += 10;
        case sc.Quality.unknown:
          v += 0;
      }
      return v;
    }

    final sorted = [...streams]..sort((a, b) => score(b).compareTo(score(a)));
    return sorted.first;
  }

  @override
  Future<List<ScTrack>> getTrendingTracks({int limit = 30}) async {
    return searchTracks('trending', limit: limit);
  }

  ScTrack _mapTrack(sc.Track t) => ScTrack(
        id: t.id.toString(),
        title: t.title,
        author: _mapMiniUser(t.user),
        artworkUrl: _hiResArtwork(t.artworkUrl?.toString()),
        permalinkUrl: t.permalinkUrl.toString(),
        description: t.description,
        duration: Duration(milliseconds: t.duration.toInt()),
        playCount: t.playbackCount.toInt(),
        likeCount: t.likesCount.toInt(),
        genres: [if (t.genre != null && t.genre!.isNotEmpty) t.genre!],
      );

  ScTrack _mapTrackSearch(sc.TrackSearchResult t) => ScTrack(
        id: t.id.toString(),
        title: t.title,
        author: _mapMiniUser(t.user),
        artworkUrl: _hiResArtwork(t.artworkUrl?.toString()),
        permalinkUrl: t.permalinkUrl.toString(),
        description: t.description,
        duration: Duration(milliseconds: t.duration.toInt()),
        playCount: t.playbackCount.toInt(),
        likeCount: t.likesCount.toInt(),
        genres: [if (t.genre != null && t.genre!.isNotEmpty) t.genre!],
      );

  ScPlaylist _mapPlaylistSearch(sc.PlaylistSearchResult p) => ScPlaylist(
        id: p.id.toString(),
        title: p.title,
        author: _mapMiniUser(p.user),
        artworkUrl: _hiResArtwork(p.artworkUrl?.toString()),
        permalinkUrl: p.permalinkUrl.toString(),
        trackCount: p.trackCount.toInt(),
      );

  ScUser _mapMiniUser(dynamic u) => ScUser(
        id: u.id.toString(),
        username: u.username as String,
        displayName: u.fullName as String?,
        avatarUrl: _hiResArtwork((u.avatarUrl as Uri?)?.toString()),
        permalinkUrl: (u.permalinkUrl as Uri).toString(),
        followerCount: (u.followersCount as num).toInt(),
      );

  String? _hiResArtwork(String? url) =>
      url?.replaceAll('-large.', '-t500x500.');
}
