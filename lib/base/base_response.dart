import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_response.g.dart';

/// [BaseResponse]
@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class BaseResponse<T, V> {
  /// data
  final T? data;

  /// error
  final V? error;

  /// data option
  Option<T> get dataOption => optionOf(data);

  /// error option
  Option<V> get errorOption => optionOf(error);

  /// default constructor
  BaseResponse({
    required this.data,
    required this.error,
  });

  /// [fromJson]
  factory BaseResponse.fromJson(
          Map<String, dynamic> json,
          T Function(Object? json) fromJsonT,
          V Function(Object? json) fromJsonV) =>
      _$BaseResponseFromJson(
        json,
        fromJsonT,
        fromJsonV,
      );
}
