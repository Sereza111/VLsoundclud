import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/theme/app_theme.dart';

/// Default bundled Web/HTML visual (`chrome_cubes_portrait.html`).
const String kChromeCubesPortraitAsset =
    'assets/animations/web/chrome_cubes_portrait.html';

/// Blender-art / HTML hand-off slot.
///
/// Resolution order (first match wins):
///   1. [kChromeCubesPortraitAsset] — математическое демо с кубами (Three.js)
///   2. `assets/animations/web/<animation>.html`
///   3. `assets/animations/video/<animation>.webm` / `.mp4`
///   4. Анимированный плейсхолдер
///
/// HTML грузится через [WebViewWidget] (нужен интернет для CDN three.js).
class BlenderArtSlot extends StatefulWidget {
  const BlenderArtSlot({
    super.key,
    required this.animation,
    this.size = 320,
  });

  /// Basename без расширения, напр. `visualizer_active`.
  final String animation;
  final double size;

  @override
  State<BlenderArtSlot> createState() => _BlenderArtSlotState();
}

enum _SlotState { detecting, web, video, placeholder }

class _BlenderArtSlotState extends State<BlenderArtSlot> {
  _SlotState _state = _SlotState.detecting;
  VideoPlayerController? _video;
  WebViewController? _web;
  /// HTML canvas в ассете 320×560 — масштабируем от [widget.size].
  static const double _canvasAspect = 560 / 320;

  @override
  void initState() {
    super.initState();
    unawaited(_detect());
  }

  Future<void> _detect() async {
    final htmlCandidates = <String>[
      kChromeCubesPortraitAsset,
      'assets/animations/web/${widget.animation}.html',
    ];

    for (final path in htmlCandidates) {
      if (await _assetExists(path)) {
        final controller = WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setBackgroundColor(Colors.transparent);

        await controller.loadFlutterAsset(path);
        // Three.js тянется с CDN — даём странице отрисоваться перед скрытием UI.
        await Future<void>.delayed(const Duration(milliseconds: 1500));
        try {
          await controller.runJavaScript(_embedCompactUiScript);
        } catch (_) {}

        if (!mounted) return;
        setState(() {
          _state = _SlotState.web;
          _web = controller;
        });
        return;
      }
    }

    final videoCandidates = <String>[
      'assets/animations/video/${widget.animation}.webm',
      'assets/animations/video/${widget.animation}.mp4',
    ];

    for (final path in videoCandidates) {
      if (await _assetExists(path)) {
        final controller = VideoPlayerController.asset(path);
        await controller.initialize();
        await controller.setLooping(true);
        await controller.setVolume(0);
        await controller.play();
        if (!mounted) {
          await controller.dispose();
          return;
        }
        setState(() {
          _state = _SlotState.video;
          _video = controller;
        });
        return;
      }
    }

    if (mounted) setState(() => _state = _SlotState.placeholder);
  }

  static const _embedCompactUiScript = '''
(function(){
  var side = document.getElementById('side');
  if (side) side.style.display = 'none';
  var wrap = document.getElementById('wrap');
  if (wrap) {
    wrap.style.display = 'flex';
    wrap.style.flexDirection = 'column';
    wrap.style.alignItems = 'center';
    wrap.style.gap = '0';
    wrap.style.width = '100%';
  }
  var c = document.getElementById('c');
  if (c) {
    c.style.borderRadius = '20px';
    c.style.maxWidth = '100%';
  }
})();
''';

  Future<bool> _assetExists(String path) async {
    try {
      await rootBundle.load(path);
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _video?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = widget.size;
    final h = w * _canvasAspect;

    final Widget child = switch (_state) {
      _SlotState.detecting => const SizedBox.shrink(),
      _SlotState.web => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: w,
            height: h,
            child: WebViewWidget(controller: _web!),
          ),
        ),
      _SlotState.video => AspectRatio(
          aspectRatio: _video!.value.aspectRatio,
          child: VideoPlayer(_video!),
        ),
      _SlotState.placeholder => const _Placeholder(),
    };

    final boxHeight = _state == _SlotState.web ? h : w;
    return SizedBox(width: w, height: boxHeight, child: child);
  }
}

class _Placeholder extends StatefulWidget {
  const _Placeholder();

  @override
  State<_Placeholder> createState() => _PlaceholderState();
}

class _PlaceholderState extends State<_Placeholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final t = _ctrl.value;
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: SweepGradient(
              startAngle: 0,
              endAngle: 6.28318,
              transform: GradientRotation(t * 6.28318),
              colors: const [
                AppColors.accent,
                AppColors.accentAlt,
                AppColors.accentGlow,
                AppColors.accent,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.35),
                blurRadius: 80,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.background,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Нет ассета\nвизуала',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 12,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
