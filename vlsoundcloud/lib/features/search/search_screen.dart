import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/audio/audio_controller.dart';
import '../../data/soundcloud/soundcloud_providers.dart';
import '../../shared/widgets/track_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchQueryProvider.notifier).set(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final results = ref.watch(searchTracksProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: TextField(
                controller: _controller,
                autofocus: false,
                style: const TextStyle(fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Найти трек, артиста, плейлист',
                  prefixIcon: Icon(Icons.search,
                      color: AppColors.textSecondary, size: 22),
                ),
                textInputAction: TextInputAction.search,
                onChanged: _onChanged,
              ),
            ),
            Expanded(
              child: results.when(
                data: (tracks) {
                  if (_controller.text.trim().isEmpty) {
                    return const _Empty(
                      icon: Icons.search,
                      message: 'Начни печатать, чтобы искать',
                    );
                  }
                  if (tracks.isEmpty) {
                    return const _Empty(
                      icon: Icons.sentiment_dissatisfied,
                      message: 'Ничего не нашлось',
                    );
                  }
                  return ListView.builder(
                    itemCount: tracks.length,
                    itemBuilder: (context, i) {
                      final track = tracks[i];
                      return TrackTile(
                        track: track,
                        onTap: () async {
                          await ref
                              .read(audioControllerProvider)
                              .setQueue(tracks, startIndex: i);
                          if (context.mounted) {
                            context.push(AppRoutes.player);
                          }
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                ),
                error: (e, _) => _Empty(
                  icon: Icons.error_outline,
                  message: 'Ошибка: $e',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.icon, required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 56, color: AppColors.textMuted),
          const SizedBox(height: 12),
          Text(message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMuted)),
        ],
      ),
    );
  }
}
