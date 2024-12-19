import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response.freezed.dart';
part 'error_response.g.dart';

/// [ErrorResponse]

@freezed
class ErrorResponse with _$ErrorResponse {
  /// response code option
  Option<String> get responseCodeOption => optionOf(responseCode);

  /// description option
  Option<String> get descriptionOption => optionOf(description);

  /// default constructor
  factory ErrorResponse({
    required String? responseCode,
    required String? description,
  }) = _ErrorResponse;

  /// [fromJson]
  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  const ErrorResponse._();
}
