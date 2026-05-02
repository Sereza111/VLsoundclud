// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sc_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScTrackImpl _$$ScTrackImplFromJson(Map<String, dynamic> json) =>
    _$ScTrackImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      author: ScUser.fromJson(json['author'] as Map<String, dynamic>),
      artworkUrl: json['artworkUrl'] as String?,
      permalinkUrl: json['permalinkUrl'] as String?,
      description: json['description'] as String?,
      duration: json['duration'] == null
          ? Duration.zero
          : Duration(microseconds: (json['duration'] as num).toInt()),
      playCount: (json['playCount'] as num?)?.toInt() ?? 0,
      likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
      genres: (json['genres'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ScTrackImplToJson(_$ScTrackImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'artworkUrl': instance.artworkUrl,
      'permalinkUrl': instance.permalinkUrl,
      'description': instance.description,
      'duration': instance.duration.inMicroseconds,
      'playCount': instance.playCount,
      'likeCount': instance.likeCount,
      'genres': instance.genres,
    };
