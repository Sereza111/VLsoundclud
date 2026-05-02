// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sc_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScUserImpl _$$ScUserImplFromJson(Map<String, dynamic> json) => _$ScUserImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      permalinkUrl: json['permalinkUrl'] as String?,
      followerCount: (json['followerCount'] as num?)?.toInt() ?? 0,
      trackCount: (json['trackCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ScUserImplToJson(_$ScUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'permalinkUrl': instance.permalinkUrl,
      'followerCount': instance.followerCount,
      'trackCount': instance.trackCount,
    };
