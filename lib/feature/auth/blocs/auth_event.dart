import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:interview_source_package/rest_client/auth/request/login_request.dart';

part 'auth_event.freezed.dart';

@freezed

/// [AuthEvent]
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required LoginRequest request,
  }) = _Login;

  const factory AuthEvent.logout() = _Logout;
}
