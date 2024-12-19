// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T, V> _$BaseResponseFromJson<T, V>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
  V Function(Object? json) fromJsonV,
) =>
    BaseResponse<T, V>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      error: _$nullableGenericFromJson(json['error'], fromJsonV),
    );

Map<String, dynamic> _$BaseResponseToJson<T, V>(
  BaseResponse<T, V> instance,
  Object? Function(T value) toJsonT,
  Object? Function(V value) toJsonV,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'error': _$nullableGenericToJson(instance.error, toJsonV),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
