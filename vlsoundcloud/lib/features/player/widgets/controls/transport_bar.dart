import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/audio/audio_controller.dart';

/// Seek slider + transport buttons for the full-screen player.
class TransportBar extends ConsumerWidget {
  const TransportBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(audioControllerProvider);
    final position = ref.watch(playerPositionProvider).value ?? Duration.zero;
    final duration = ref.watch(playerDurationProvider).value ?? Duration.zero;
    final isPlaying = ref.watch(isPlayingProvider).value ?? false;
    final processing =
        ref.watch(processingStateProvider).value ?? ProcessingState.idle;

    return Column(
      children: [
        Slider(
          min: 0,
          max: duration.inMilliseconds.toDouble().clamp(1, double.infinity),
          value: position.inMilliseconds
              .clamp(0, duration.inMilliseconds)
              .toDouble(),
          onChanged: duration.inMilliseconds == 0
              ? null
              : (v) => controller.seek(Duration(milliseconds: v.toInt())),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_fmt(position),
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12)),
              Text(_fmt(duration),
                  style: const TextStyle(
                      color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.shuffle, size: 22),
              color: AppColors.textSecondary,
              onPressed: () =>
                  controller.setShuffle(!controller.player.shuffleModeEnabled),
            ),
            IconButton(
              iconSize: 38,
              icon: const Icon(Icons.skip_previous_rounded),
              onPressed: controller.seekToPrevious,
            ),
            _PlayPauseButton(
              isPlaying: isPlaying,
              isLoading: processing == ProcessingState.loading ||
                  processing == ProcessingState.buffering,
              onTap: () => isPlaying ? controller.pause() : controller.play(),
            ),
            IconButton(
              iconSize: 38,
              icon: const Icon(Icons.skip_next_rounded),
              onPressed: controller.seekToNext,
            ),
            IconButton(
              icon: const Icon(Icons.repeat, size: 22),
              color: AppColors.textSecondary,
              onPressed: () => controller.setLoopMode(
                controller.player.loopMode == LoopMode.off
                    ? LoopMode.one
                    : LoopMode.off,
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _fmt(Duration d) {
    String two(int n) => n.toString().padLeft(2, '0');
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    return '${two(m)}:${two(s)}';
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({
    required this.isPlaying,
    required this.isLoading,
    required this.onTap,
  });

  final bool isPlaying;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          gradient: AppColors.accentGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.45),
              blurRadius: 24,
              spreadRadius: 1,
            ),
          ],
        ),
        child: isLoading
            ? const Padding(
                padding: EdgeInsets.all(22),
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Icon(
                isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                size: 42,
                color: Colors.white,
              ),
      ),
    );
  }
}
