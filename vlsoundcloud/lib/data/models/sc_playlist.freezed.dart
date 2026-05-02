// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sc_playlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScPlaylist _$ScPlaylistFromJson(Map<String, dynamic> json) {
  return _ScPlaylist.fromJson(json);
}

/// @nodoc
mixin _$ScPlaylist {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  ScUser get author => throw _privateConstructorUsedError;
  String? get artworkUrl => throw _privateConstructorUsedError;
  String? get permalinkUrl => throw _privateConstructorUsedError;
  List<ScTrack> get tracks => throw _privateConstructorUsedError;
  int get trackCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScPlaylistCopyWith<ScPlaylist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScPlaylistCopyWith<$Res> {
  factory $ScPlaylistCopyWith(
          ScPlaylist value, $Res Function(ScPlaylist) then) =
      _$ScPlaylistCopyWithImpl<$Res, ScPlaylist>;
  @useResult
  $Res call(
      {String id,
      String title,
      ScUser author,
      String? artworkUrl,
      String? permalinkUrl,
      List<ScTrack> tracks,
      int trackCount});

  $ScUserCopyWith<$Res> get author;
}

/// @nodoc
class _$ScPlaylistCopyWithImpl<$Res, $Val extends ScPlaylist>
    implements $ScPlaylistCopyWith<$Res> {
  _$ScPlaylistCopyWithImpl(this._value, this._then);

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
    Object? tracks = null,
    Object? trackCount = null,
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
      tracks: null == tracks
          ? _value.tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<ScTrack>,
      trackCount: null == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int,
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
abstract class _$$ScPlaylistImplCopyWith<$Res>
    implements $ScPlaylistCopyWith<$Res> {
  factory _$$ScPlaylistImplCopyWith(
          _$ScPlaylistImpl value, $Res Function(_$ScPlaylistImpl) then) =
      __$$ScPlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      ScUser author,
      String? artworkUrl,
      String? permalinkUrl,
      List<ScTrack> tracks,
      int trackCount});

  @override
  $ScUserCopyWith<$Res> get author;
}

/// @nodoc
class __$$ScPlaylistImplCopyWithImpl<$Res>
    extends _$ScPlaylistCopyWithImpl<$Res, _$ScPlaylistImpl>
    implements _$$ScPlaylistImplCopyWith<$Res> {
  __$$ScPlaylistImplCopyWithImpl(
      _$ScPlaylistImpl _value, $Res Function(_$ScPlaylistImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? artworkUrl = freezed,
    Object? permalinkUrl = freezed,
    Object? tracks = null,
    Object? trackCount = null,
  }) {
    return _then(_$ScPlaylistImpl(
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
      tracks: null == tracks
          ? _value._tracks
          : tracks // ignore: cast_nullable_to_non_nullable
              as List<ScTrack>,
      trackCount: null == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScPlaylistImpl implements _ScPlaylist {
  const _$ScPlaylistImpl(
      {required this.id,
      required this.title,
      required this.author,
      this.artworkUrl,
      this.permalinkUrl,
      final List<ScTrack> tracks = const [],
      this.trackCount = 0})
      : _tracks = tracks;

  factory _$ScPlaylistImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScPlaylistImplFromJson(json);

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
  final List<ScTrack> _tracks;
  @override
  @JsonKey()
  List<ScTrack> get tracks {
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tracks);
  }

  @override
  @JsonKey()
  final int trackCount;

  @override
  String toString() {
    return 'ScPlaylist(id: $id, title: $title, author: $author, artworkUrl: $artworkUrl, permalinkUrl: $permalinkUrl, tracks: $tracks, trackCount: $trackCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScPlaylistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.artworkUrl, artworkUrl) ||
                other.artworkUrl == artworkUrl) &&
            (identical(other.permalinkUrl, permalinkUrl) ||
                other.permalinkUrl == permalinkUrl) &&
            const DeepCollectionEquality().equals(other._tracks, _tracks) &&
            (identical(other.trackCount, trackCount) ||
                other.trackCount == trackCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, author, artworkUrl,
      permalinkUrl, const DeepCollectionEquality().hash(_tracks), trackCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScPlaylistImplCopyWith<_$ScPlaylistImpl> get copyWith =>
      __$$ScPlaylistImplCopyWithImpl<_$ScPlaylistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScPlaylistImplToJson(
      this,
    );
  }
}

abstract class _ScPlaylist implements ScPlaylist {
  const factory _ScPlaylist(
      {required final String id,
      required final String title,
      required final ScUser author,
      final String? artworkUrl,
      final String? permalinkUrl,
      final List<ScTrack> tracks,
      final int trackCount}) = _$ScPlaylistImpl;

  factory _ScPlaylist.fromJson(Map<String, dynamic> json) =
      _$ScPlaylistImpl.fromJson;

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
  List<ScTrack> get tracks;
  @override
  int get trackCount;
  @override
  @JsonKey(ignore: true)
  _$$ScPlaylistImplCopyWith<_$ScPlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
