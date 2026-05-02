// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sc_playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScPlaylistImpl _$$ScPlaylistImplFromJson(Map<String, dynamic> json) =>
    _$ScPlaylistImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      author: ScUser.fromJson(json['author'] as Map<String, dynamic>),
      artworkUrl: json['artworkUrl'] as String?,
      permalinkUrl: json['permalinkUrl'] as String?,
      tracks: (json['tracks'] as List<dynamic>?)
              ?.map((e) => ScTrack.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      trackCount: (json['trackCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ScPlaylistImplToJson(_$ScPlaylistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'artworkUrl': instance.artworkUrl,
      'permalinkUrl': instance.permalinkUrl,
      'tracks': instance.tracks,
      'trackCount': instance.trackCount,
    };
