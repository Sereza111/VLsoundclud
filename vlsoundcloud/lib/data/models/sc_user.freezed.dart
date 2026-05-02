// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sc_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScUser _$ScUserFromJson(Map<String, dynamic> json) {
  return _ScUser.fromJson(json);
}

/// @nodoc
mixin _$ScUser {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get permalinkUrl => throw _privateConstructorUsedError;
  int get followerCount => throw _privateConstructorUsedError;
  int get trackCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScUserCopyWith<ScUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScUserCopyWith<$Res> {
  factory $ScUserCopyWith(ScUser value, $Res Function(ScUser) then) =
      _$ScUserCopyWithImpl<$Res, ScUser>;
  @useResult
  $Res call(
      {String id,
      String username,
      String? displayName,
      String? avatarUrl,
      String? permalinkUrl,
      int followerCount,
      int trackCount});
}

/// @nodoc
class _$ScUserCopyWithImpl<$Res, $Val extends ScUser>
    implements $ScUserCopyWith<$Res> {
  _$ScUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? permalinkUrl = freezed,
    Object? followerCount = null,
    Object? trackCount = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      permalinkUrl: freezed == permalinkUrl
          ? _value.permalinkUrl
          : permalinkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      trackCount: null == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScUserImplCopyWith<$Res> implements $ScUserCopyWith<$Res> {
  factory _$$ScUserImplCopyWith(
          _$ScUserImpl value, $Res Function(_$ScUserImpl) then) =
      __$$ScUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String username,
      String? displayName,
      String? avatarUrl,
      String? permalinkUrl,
      int followerCount,
      int trackCount});
}

/// @nodoc
class __$$ScUserImplCopyWithImpl<$Res>
    extends _$ScUserCopyWithImpl<$Res, _$ScUserImpl>
    implements _$$ScUserImplCopyWith<$Res> {
  __$$ScUserImplCopyWithImpl(
      _$ScUserImpl _value, $Res Function(_$ScUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? permalinkUrl = freezed,
    Object? followerCount = null,
    Object? trackCount = null,
  }) {
    return _then(_$ScUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      permalinkUrl: freezed == permalinkUrl
          ? _value.permalinkUrl
          : permalinkUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      followerCount: null == followerCount
          ? _value.followerCount
          : followerCount // ignore: cast_nullable_to_non_nullable
              as int,
      trackCount: null == trackCount
          ? _value.trackCount
          : trackCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScUserImpl implements _ScUser {
  const _$ScUserImpl(
      {required this.id,
      required this.username,
      this.displayName,
      this.avatarUrl,
      this.permalinkUrl,
      this.followerCount = 0,
      this.trackCount = 0});

  factory _$ScUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScUserImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  final String? permalinkUrl;
  @override
  @JsonKey()
  final int followerCount;
  @override
  @JsonKey()
  final int trackCount;

  @override
  String toString() {
    return 'ScUser(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, permalinkUrl: $permalinkUrl, followerCount: $followerCount, trackCount: $trackCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.permalinkUrl, permalinkUrl) ||
                other.permalinkUrl == permalinkUrl) &&
            (identical(other.followerCount, followerCount) ||
                other.followerCount == followerCount) &&
            (identical(other.trackCount, trackCount) ||
                other.trackCount == trackCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, displayName,
      avatarUrl, permalinkUrl, followerCount, trackCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScUserImplCopyWith<_$ScUserImpl> get copyWith =>
      __$$ScUserImplCopyWithImpl<_$ScUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScUserImplToJson(
      this,
    );
  }
}

abstract class _ScUser implements ScUser {
  const factory _ScUser(
      {required final String id,
      required final String username,
      final String? displayName,
      final String? avatarUrl,
      final String? permalinkUrl,
      final int followerCount,
      final int trackCount}) = _$ScUserImpl;

  factory _ScUser.fromJson(Map<String, dynamic> json) = _$ScUserImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  String? get permalinkUrl;
  @override
  int get followerCount;
  @override
  int get trackCount;
  @override
  @JsonKey(ignore: true)
  _$$ScUserImplCopyWith<_$ScUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
