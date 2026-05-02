import 'package:freezed_annotation/freezed_annotation.dart';

part 'sc_user.freezed.dart';
part 'sc_user.g.dart';

@freezed
class ScUser with _$ScUser {
  const factory ScUser({
    required String id,
    required String username,
    String? displayName,
    String? avatarUrl,
    String? permalinkUrl,
    @Default(0) int followerCount,
    @Default(0) int trackCount,
  }) = _ScUser;

  factory ScUser.fromJson(Map<String, dynamic> json) => _$ScUserFromJson(json);
}
