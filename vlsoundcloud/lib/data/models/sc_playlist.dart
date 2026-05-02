import 'package:freezed_annotation/freezed_annotation.dart';

import 'sc_track.dart';
import 'sc_user.dart';

part 'sc_playlist.freezed.dart';
part 'sc_playlist.g.dart';

@freezed
class ScPlaylist with _$ScPlaylist {
  const factory ScPlaylist({
    required String id,
    required String title,
    required ScUser author,
    String? artworkUrl,
    String? permalinkUrl,
    @Default([]) List<ScTrack> tracks,
    @Default(0) int trackCount,
  }) = _ScPlaylist;

  factory ScPlaylist.fromJson(Map<String, dynamic> json) =>
      _$ScPlaylistFromJson(json);
}
