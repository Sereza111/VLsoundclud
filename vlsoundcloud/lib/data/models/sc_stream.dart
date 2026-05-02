import 'package:freezed_annotation/freezed_annotation.dart';

part 'sc_stream.freezed.dart';
part 'sc_stream.g.dart';

/// Represents a playable URL resolved for a [ScTrack].
///
/// SoundCloud streams come in two transport formats:
/// - Progressive MP3 — easiest, plays directly via just_audio.
/// - HLS (m3u8) — adaptive, also supported by just_audio out of the box.
@freezed
class ScStream with _$ScStream {
  const factory ScStream({
    required String url,
    required ScStreamFormat format,
    @Default('audio/mpeg') String mimeType,
  }) = _ScStream;

  factory ScStream.fromJson(Map<String, dynamic> json) =>
      _$ScStreamFromJson(json);
}

enum ScStreamFormat {
  @JsonValue('progressive')
  progressive,
  @JsonValue('hls')
  hls,
}
