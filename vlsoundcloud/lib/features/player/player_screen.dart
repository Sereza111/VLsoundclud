import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../data/audio/audio_controller.dart';
import 'widgets/controls/transport_bar.dart';
import 'widgets/equalizer/eq_panel.dart';
import 'widgets/visualizer/blender_art_slot.dart';
import 'widgets/visualizer/fft_bars.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final track = ref.watch(currentTrackProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 32),
          onPressed: () => context.pop(),
        ),
        actions: [
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.tune_rounded),
              onPressed: () => showModalBottomSheet(
                context: ctx,
                backgroundColor: AppColors.surface,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const EqPanel(),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (track?.artworkUrl != null)
            Positioned.fill(
              child: ImageFiltered(
                imageFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken),
                child: CachedNetworkImage(
                  imageUrl: track!.artworkUrl!,
                  fit: BoxFit.cover,
                  errorWidget: (_, _, _) => Container(color: AppColors.background),
                ),
              ),
            ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(gradient: AppColors.surfaceGradient),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Stack(
                      alignment: Alignment.center,
                      children: const [
                        BlenderArtSlot(animation: 'visualizer_active'),
                        FftBars(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (track != null) ...[
                    Text(
                      track.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      track.author.displayName ?? track.author.username,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  const TransportBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
