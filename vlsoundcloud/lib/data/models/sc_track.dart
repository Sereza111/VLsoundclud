import 'package:freezed_annotation/freezed_annotation.dart';

import 'sc_user.dart';

part 'sc_track.freezed.dart';
part 'sc_track.g.dart';

@freezed
class ScTrack with _$ScTrack {
  const factory ScTrack({
    required String id,
    required String title,
    required ScUser author,
    String? artworkUrl,
    String? permalinkUrl,
    String? description,
    @Default(Duration.zero) Duration duration,
    @Default(0) int playCount,
    @Default(0) int likeCount,
    @Default([]) List<String> genres,
  }) = _ScTrack;

  factory ScTrack.fromJson(Map<String, dynamic> json) =>
      _$ScTrackFromJson(json);
}
