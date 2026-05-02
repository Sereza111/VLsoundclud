// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sc_stream.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScStreamImpl _$$ScStreamImplFromJson(Map<String, dynamic> json) =>
    _$ScStreamImpl(
      url: json['url'] as String,
      format: $enumDecode(_$ScStreamFormatEnumMap, json['format']),
      mimeType: json['mimeType'] as String? ?? 'audio/mpeg',
    );

Map<String, dynamic> _$$ScStreamImplToJson(_$ScStreamImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'format': _$ScStreamFormatEnumMap[instance.format]!,
      'mimeType': instance.mimeType,
    };

const _$ScStreamFormatEnumMap = {
  ScStreamFormat.progressive: 'progressive',
  ScStreamFormat.hls: 'hls',
};
