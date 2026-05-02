import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../data/audio/audio_controller.dart';

/// User-facing audio equalizer panel.
///
/// Wraps [AndroidEqualizer] from just_audio. The platform reports the band
/// list and gain range — we just render sliders. iOS support is out of scope
/// for the foundation (no equivalent built-in effect).
class EqPanel extends ConsumerStatefulWidget {
  const EqPanel({super.key});

  @override
  ConsumerState<EqPanel> createState() => _EqPanelState();
}

class _EqPanelState extends ConsumerState<EqPanel> {
  static const _prefsKey = 'eq.gains.v1';
  static const _enabledKey = 'eq.enabled.v1';

  AndroidEqualizerParameters? _params;
  bool _enabled = false;

  @override
  void initState() {
    super.initState();
    unawaited(_load());
  }

  Future<void> _load() async {
    final eq = ref.read(audioControllerProvider).equalizer;
    final params = await eq.parameters;
    final prefs = await SharedPreferences.getInstance();

    _enabled = prefs.getBool(_enabledKey) ?? false;
    await eq.setEnabled(_enabled);

    final stored = prefs.getString(_prefsKey);
    if (stored != null) {
      final list = (jsonDecode(stored) as List).cast<num>();
      for (var i = 0; i < params.bands.length && i < list.length; i++) {
        await params.bands[i].setGain(list[i].toDouble());
      }
    }

    if (!mounted) return;
    setState(() => _params = params);
  }

  Future<void> _persist() async {
    if (_params == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefsKey,
      jsonEncode(_params!.bands.map((b) => b.gain).toList()),
    );
    await prefs.setBool(_enabledKey, _enabled);
  }

  Future<void> _resetFlat() async {
    if (_params == null) return;
    for (final band in _params!.bands) {
      await band.setGain(0);
    }
    setState(() {});
    await _persist();
  }

  Future<void> _applyPreset(_Preset preset) async {
    if (_params == null) return;
    for (var i = 0; i < _params!.bands.length; i++) {
      final gain = i < preset.gains.length ? preset.gains[i] : 0.0;
      await _params!.bands[i].setGain(gain);
    }
    setState(() {});
    await _persist();
  }

  @override
  Widget build(BuildContext context) {
    final eq = ref.watch(audioControllerProvider).equalizer;
    final params = _params;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Эквалайзер',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
                const Spacer(),
                Switch.adaptive(
                  value: _enabled,
                  activeThumbColor: AppColors.accent,
                  onChanged: (v) async {
                    setState(() => _enabled = v);
                    await eq.setEnabled(v);
                    await _persist();
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (params == null)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.accent),
                ),
              )
            else ...[
              SizedBox(
                height: 240,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final band in params.bands)
                      Expanded(
                        child: _BandSlider(
                          band: band,
                          min: params.minDecibels,
                          max: params.maxDecibels,
                          enabled: _enabled,
                          onChanged: () async {
                            setState(() {});
                            await _persist();
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _PresetChip(
                      label: 'Flat',
                      onTap: _resetFlat,
                    ),
                    const SizedBox(width: 8),
                    for (final preset in _presets)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _PresetChip(
                          label: preset.name,
                          onTap: () => _applyPreset(preset),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BandSlider extends StatelessWidget {
  const _BandSlider({
    required this.band,
    required this.min,
    required this.max,
    required this.enabled,
    required this.onChanged,
  });

  final AndroidEqualizerBand band;
  final double min;
  final double max;
  final bool enabled;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: band.gainStream,
      initialData: band.gain,
      builder: (context, snapshot) {
        final gain = snapshot.data ?? 0;
        return Column(
          children: [
            Expanded(
              child: RotatedBox(
                quarterTurns: -1,
                child: Slider(
                  min: min,
                  max: max,
                  value: gain.clamp(min, max),
                  onChanged: enabled
                      ? (v) async {
                          await band.setGain(v);
                          onChanged();
                        }
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _fmtFreq(band.centerFrequency),
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '${gain.toStringAsFixed(1)} dB',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textMuted,
              ),
            ),
          ],
        );
      },
    );
  }

  static String _fmtFreq(double hz) {
    if (hz >= 1000) return '${(hz / 1000).toStringAsFixed(hz % 1000 == 0 ? 0 : 1)}k';
    return '${hz.toInt()}';
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceElevated,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _Preset {
  const _Preset(this.name, this.gains);
  final String name;
  final List<double> gains;
}

const _presets = <_Preset>[
  _Preset('Bass +', [6, 4, 1, -1, -2]),
  _Preset('Vocal', [-2, 0, 4, 4, 1]),
  _Preset('Treble +', [-2, -1, 0, 3, 6]),
  _Preset('Lo-Fi', [3, 2, -3, -2, 1]),
];
