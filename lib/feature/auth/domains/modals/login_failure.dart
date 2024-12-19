import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_failure.freezed.dart';

@freezed
class LoginFailure with _$LoginFailure {
  const factory LoginFailure.unexpected({required String error}) =
      _LoginFailureUnexpected;

  const factory LoginFailure.unauthorized() = _LoginFailureUnauthorized;

  const factory LoginFailure.unauthenticated() = _LoginFailureUnauthenticated;

  const factory LoginFailure.wrongFormatUserName({required String error}) =
      _LoginFailureWrongFormatUsername;

  const factory LoginFailure.wrongFormatPassword({required String error}) =
      _LoginFailureWrongFormatPassword;

  const factory LoginFailure.serverError() = _LoginFailureServerError;

  const factory LoginFailure.wrongUserPassword() = _WrongUserPassword;

  const factory LoginFailure.timeOut() = _LoginFailureTimeOut;

  const factory LoginFailure.firebaseLoginError({
    required String error,
  }) = _LoginFailureFirebaseLoginError;

  const factory LoginFailure.noInternet() = _LoginFailureNoInternet;
}
