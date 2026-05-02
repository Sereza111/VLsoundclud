// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sc_stream.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScStream _$ScStreamFromJson(Map<String, dynamic> json) {
  return _ScStream.fromJson(json);
}

/// @nodoc
mixin _$ScStream {
  String get url => throw _privateConstructorUsedError;
  ScStreamFormat get format => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScStreamCopyWith<ScStream> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScStreamCopyWith<$Res> {
  factory $ScStreamCopyWith(ScStream value, $Res Function(ScStream) then) =
      _$ScStreamCopyWithImpl<$Res, ScStream>;
  @useResult
  $Res call({String url, ScStreamFormat format, String mimeType});
}

/// @nodoc
class _$ScStreamCopyWithImpl<$Res, $Val extends ScStream>
    implements $ScStreamCopyWith<$Res> {
  _$ScStreamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? format = null,
    Object? mimeType = null,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ScStreamFormat,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScStreamImplCopyWith<$Res>
    implements $ScStreamCopyWith<$Res> {
  factory _$$ScStreamImplCopyWith(
          _$ScStreamImpl value, $Res Function(_$ScStreamImpl) then) =
      __$$ScStreamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, ScStreamFormat format, String mimeType});
}

/// @nodoc
class __$$ScStreamImplCopyWithImpl<$Res>
    extends _$ScStreamCopyWithImpl<$Res, _$ScStreamImpl>
    implements _$$ScStreamImplCopyWith<$Res> {
  __$$ScStreamImplCopyWithImpl(
      _$ScStreamImpl _value, $Res Function(_$ScStreamImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? format = null,
    Object? mimeType = null,
  }) {
    return _then(_$ScStreamImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      format: null == format
          ? _value.format
          : format // ignore: cast_nullable_to_non_nullable
              as ScStreamFormat,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScStreamImpl implements _ScStream {
  const _$ScStreamImpl(
      {required this.url, required this.format, this.mimeType = 'audio/mpeg'});

  factory _$ScStreamImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScStreamImplFromJson(json);

  @override
  final String url;
  @override
  final ScStreamFormat format;
  @override
  @JsonKey()
  final String mimeType;

  @override
  String toString() {
    return 'ScStream(url: $url, format: $format, mimeType: $mimeType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScStreamImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.format, format) || other.format == format) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, url, format, mimeType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScStreamImplCopyWith<_$ScStreamImpl> get copyWith =>
      __$$ScStreamImplCopyWithImpl<_$ScStreamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScStreamImplToJson(
      this,
    );
  }
}

abstract class _ScStream implements ScStream {
  const factory _ScStream(
      {required final String url,
      required final ScStreamFormat format,
      final String mimeType}) = _$ScStreamImpl;

  factory _ScStream.fromJson(Map<String, dynamic> json) =
      _$ScStreamImpl.fromJson;

  @override
  String get url;
  @override
  ScStreamFormat get format;
  @override
  String get mimeType;
  @override
  @JsonKey(ignore: true)
  _$$ScStreamImplCopyWith<_$ScStreamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
