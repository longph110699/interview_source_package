// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'be_server_login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BEServerLoginResponse _$BEServerLoginResponseFromJson(
    Map<String, dynamic> json) {
  return _BEServerLoginResponse.fromJson(json);
}

/// @nodoc
mixin _$BEServerLoginResponse {
  String get token => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BEServerLoginResponseCopyWith<BEServerLoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BEServerLoginResponseCopyWith<$Res> {
  factory $BEServerLoginResponseCopyWith(BEServerLoginResponse value,
          $Res Function(BEServerLoginResponse) then) =
      _$BEServerLoginResponseCopyWithImpl<$Res, BEServerLoginResponse>;
  @useResult
  $Res call({String token});
}

/// @nodoc
class _$BEServerLoginResponseCopyWithImpl<$Res,
        $Val extends BEServerLoginResponse>
    implements $BEServerLoginResponseCopyWith<$Res> {
  _$BEServerLoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BEServerLoginResponseImplCopyWith<$Res>
    implements $BEServerLoginResponseCopyWith<$Res> {
  factory _$$BEServerLoginResponseImplCopyWith(
          _$BEServerLoginResponseImpl value,
          $Res Function(_$BEServerLoginResponseImpl) then) =
      __$$BEServerLoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String token});
}

/// @nodoc
class __$$BEServerLoginResponseImplCopyWithImpl<$Res>
    extends _$BEServerLoginResponseCopyWithImpl<$Res,
        _$BEServerLoginResponseImpl>
    implements _$$BEServerLoginResponseImplCopyWith<$Res> {
  __$$BEServerLoginResponseImplCopyWithImpl(_$BEServerLoginResponseImpl _value,
      $Res Function(_$BEServerLoginResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
  }) {
    return _then(_$BEServerLoginResponseImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BEServerLoginResponseImpl extends _BEServerLoginResponse {
  const _$BEServerLoginResponseImpl({required this.token}) : super._();

  factory _$BEServerLoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BEServerLoginResponseImplFromJson(json);

  @override
  final String token;

  @override
  String toString() {
    return 'BEServerLoginResponse(token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BEServerLoginResponseImpl &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BEServerLoginResponseImplCopyWith<_$BEServerLoginResponseImpl>
      get copyWith => __$$BEServerLoginResponseImplCopyWithImpl<
          _$BEServerLoginResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BEServerLoginResponseImplToJson(
      this,
    );
  }
}

abstract class _BEServerLoginResponse extends BEServerLoginResponse {
  const factory _BEServerLoginResponse({required final String token}) =
      _$BEServerLoginResponseImpl;
  const _BEServerLoginResponse._() : super._();

  factory _BEServerLoginResponse.fromJson(Map<String, dynamic> json) =
      _$BEServerLoginResponseImpl.fromJson;

  @override
  String get token;
  @override
  @JsonKey(ignore: true)
  _$$BEServerLoginResponseImplCopyWith<_$BEServerLoginResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
