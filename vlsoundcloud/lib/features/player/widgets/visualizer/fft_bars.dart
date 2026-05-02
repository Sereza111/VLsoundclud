import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/audio/audio_controller.dart';

/// Frequency-bar visualizer.
///
/// IMPORTANT — pipeline note:
/// just_audio doesn't expose raw PCM/FFT samples on Android (yet), and
/// `flutter_audio_visualizer`'s `AudioPlayerSource` is a stub. So the
/// foundation ships a *deterministic synthesized* spectrum that animates
/// only while audio is playing. It looks musical and doesn't require mic
/// permission. Replace the [_synthesizeBars] body with real FFT data once
/// the audio plugin or a sidecar (e.g. `audify`) provides it.
class FftBars extends ConsumerStatefulWidget {
  const FftBars({super.key, this.barCount = 48, this.height = 220});

  final int barCount;
  final double height;

  @override
  ConsumerState<FftBars> createState() => _FftBarsState();
}

class _FftBarsState extends ConsumerState<FftBars>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late List<double> _bars;
  final _rng = math.Random(42);

  @override
  void initState() {
    super.initState();
    _bars = List.filled(widget.barCount, 0.05);
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _ctrl.addListener(_tick);
  }

  void _tick() {
    final isPlaying = ref.read(isPlayingProvider).value ?? false;
    final t = _ctrl.lastElapsedDuration?.inMicroseconds ?? 0;
    setState(() => _bars = _synthesizeBars(t / 1e6, isPlaying));
  }

  List<double> _synthesizeBars(double seconds, bool playing) {
    final out = List<double>.filled(widget.barCount, 0);
    final amp = playing ? 1.0 : 0.0;
    for (var i = 0; i < widget.barCount; i++) {
      final norm = i / widget.barCount;
      final bass = math.exp(-norm * 4) * (0.6 + 0.4 * math.sin(seconds * 6));
      final mid = math.sin(seconds * 3 + norm * 9) * 0.4 *
          math.exp(-((norm - 0.4).abs() * 4));
      final treble = math.sin(seconds * 11 + norm * 22) * 0.3 *
          math.exp(-((norm - 0.8).abs() * 6));
      final noise = (_rng.nextDouble() - 0.5) * 0.06;
      final v = (bass + mid + treble + noise).abs() * amp;
      out[i] = v.clamp(0.02, 1.0);
    }
    return out;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: CustomPaint(
        painter: _BarsPainter(values: _bars),
        size: Size.infinite,
      ),
    );
  }
}

class _BarsPainter extends CustomPainter {
  _BarsPainter({required this.values});
  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;

    final n = values.length;
    final gap = 2.0;
    final barWidth = (size.width - gap * (n - 1)) / n;
    final centerY = size.height / 2;

    for (var i = 0; i < n; i++) {
      final v = values[i];
      final h = v * size.height;
      final left = i * (barWidth + gap);

      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(left, centerY - h / 2, barWidth, h),
        const Radius.circular(2),
      );

      final paint = Paint()
        ..shader = AppColors.accentGradient.createShader(rect.outerRect);
      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BarsPainter oldDelegate) =>
      !_listEq(oldDelegate.values, values);

  bool _listEq(List<double> a, List<double> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if ((a[i] - b[i]).abs() > 0.001) return false;
    }
    return true;
  }
}
