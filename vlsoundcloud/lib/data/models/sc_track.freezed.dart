// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sc_track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScTrack _$ScTrackFromJson(Map<String, dynamic> json) {
  return _ScTrack.fromJson(json);
}

/// @nodoc
mixin _$ScTrack {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  ScUser get author => throw _privateConstructorUsedError;
  String? get artworkUrl => throw _privateConstructorUsedError;
  String? get permalinkUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  int get playCount => throw _privateConstructorUsedError;
  int get likeCount => throw _privateConstructorUsedError;
  List<String> get genres => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScTrackCopyWith<ScTrack> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScTrackCopyWith<$Res> {
  factory $ScTrackCopyWith(ScTrack value, $Res Function(ScTrack) then) =
      _$ScTrackCopyWithImpl<$Res, ScTrack>;
  @useResult
  $Res call(
      {String id,
      String title,
      ScUser author,
      String? artworkUrl,
      String? permalinkUrl,
      String? description,
      Duration duration,
      int playCount,
      int likeCount,
      List<String> genres});

  $ScUserCopyWith<$Res> get author;
}

/// @nodoc
class _$ScTrackCopyWithImpl<$Res, $Val extends ScTrack>
    implements $ScTrackCopyWith<$Res> {
  _$ScTrackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? artworkUrl = freezed,
    Object? permalinkUrl = freezed,
    Object? description = freezed,
    Object? duration = null,
    Object? playCount = null,
    Object? likeCount = null,
    Object? genres = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ScUser,
      artworkUrl: freezed == artworkUrl
          ? _value.artworkUrl
          : artworkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      permalinkUrl: freezed == permalinkUrl
          ? _value.permalinkUrl
          : permalinkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ScUserCopyWith<$Res> get author {
    return $ScUserCopyWith<$Res>(_value.author, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ScTrackImplCopyWith<$Res> implements $ScTrackCopyWith<$Res> {
  factory _$$ScTrackImplCopyWith(
          _$ScTrackImpl value, $Res Function(_$ScTrackImpl) then) =
      __$$ScTrackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      ScUser author,
      String? artworkUrl,
      String? permalinkUrl,
      String? description,
      Duration duration,
      int playCount,
      int likeCount,
      List<String> genres});

  @override
  $ScUserCopyWith<$Res> get author;
}

/// @nodoc
class __$$ScTrackImplCopyWithImpl<$Res>
    extends _$ScTrackCopyWithImpl<$Res, _$ScTrackImpl>
    implements _$$ScTrackImplCopyWith<$Res> {
  __$$ScTrackImplCopyWithImpl(
      _$ScTrackImpl _value, $Res Function(_$ScTrackImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? artworkUrl = freezed,
    Object? permalinkUrl = freezed,
    Object? description = freezed,
    Object? duration = null,
    Object? playCount = null,
    Object? likeCount = null,
    Object? genres = null,
  }) {
    return _then(_$ScTrackImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as ScUser,
      artworkUrl: freezed == artworkUrl
          ? _value.artworkUrl
          : artworkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      permalinkUrl: freezed == permalinkUrl
          ? _value.permalinkUrl
          : permalinkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as Duration,
      playCount: null == playCount
          ? _value.playCount
          : playCount // ignore: cast_nullable_to_non_nullable
              as int,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      genres: null == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScTrackImpl implements _ScTrack {
  const _$ScTrackImpl(
      {required this.id,
      required this.title,
      required this.author,
      this.artworkUrl,
      this.permalinkUrl,
      this.description,
      this.duration = Duration.zero,
      this.playCount = 0,
      this.likeCount = 0,
      final List<String> genres = const []})
      : _genres = genres;

  factory _$ScTrackImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScTrackImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final ScUser author;
  @override
  final String? artworkUrl;
  @override
  final String? permalinkUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final Duration duration;
  @override
  @JsonKey()
  final int playCount;
  @override
  @JsonKey()
  final int likeCount;
  final List<String> _genres;
  @override
  @JsonKey()
  List<String> get genres {
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_genres);
  }

  @override
  String toString() {
    return 'ScTrack(id: $id, title: $title, author: $author, artworkUrl: $artworkUrl, permalinkUrl: $permalinkUrl, description: $description, duration: $duration, playCount: $playCount, likeCount: $likeCount, genres: $genres)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScTrackImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.artworkUrl, artworkUrl) ||
                other.artworkUrl == artworkUrl) &&
            (identical(other.permalinkUrl, permalinkUrl) ||
                other.permalinkUrl == permalinkUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.playCount, playCount) ||
                other.playCount == playCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            const DeepCollectionEquality().equals(other._genres, _genres));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      author,
      artworkUrl,
      permalinkUrl,
      description,
      duration,
      playCount,
      likeCount,
      const DeepCollectionEquality().hash(_genres));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScTrackImplCopyWith<_$ScTrackImpl> get copyWith =>
      __$$ScTrackImplCopyWithImpl<_$ScTrackImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScTrackImplToJson(
      this,
    );
  }
}

abstract class _ScTrack implements ScTrack {
  const factory _ScTrack(
      {required final String id,
      required final String title,
      required final ScUser author,
      final String? artworkUrl,
      final String? permalinkUrl,
      final String? description,
      final Duration duration,
      final int playCount,
      final int likeCount,
      final List<String> genres}) = _$ScTrackImpl;

  factory _ScTrack.fromJson(Map<String, dynamic> json) = _$ScTrackImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  ScUser get author;
  @override
  String? get artworkUrl;
  @override
  String? get permalinkUrl;
  @override
  String? get description;
  @override
  Duration get duration;
  @override
  int get playCount;
  @override
  int get likeCount;
  @override
  List<String> get genres;
  @override
  @JsonKey(ignore: true)
  _$$ScTrackImplCopyWith<_$ScTrackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
