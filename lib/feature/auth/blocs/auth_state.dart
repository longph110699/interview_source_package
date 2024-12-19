import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:interview_source_package/feature/auth/domains/modals/app_user.dart';
import 'package:interview_source_package/feature/auth/domains/modals/login_failure.dart';

part 'auth_state.freezed.dart';

@freezed

/// [AuthState]
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated({
    required List<LoginFailure> error,
  }) = _Unauthenticated;

  const factory AuthState.authenticated({
    required AppUser user,
  }) = _Authenticated;

  const factory AuthState.loading() = _Loading;
}
