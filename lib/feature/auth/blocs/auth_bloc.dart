import 'dart:async';

import 'package:interview_source_package/feature/auth/blocs/auth_event.dart';
import 'package:interview_source_package/feature/auth/blocs/auth_state.dart';
import 'package:interview_source_package/feature/auth/domains/modals/login_failure.dart';
import 'package:interview_source_package/feature/auth/domains/use_cases/auth_usecase.dart';
import 'package:interview_source_package/rest_client/auth/request/login_request.dart';

class AuthBloc {
  final AuthUseCase authUseCase;

  /// STATE
  final _stateController = StreamController<AuthState>.broadcast();
  Stream<AuthState> get state => _stateController.stream;

  AuthState _currentState = const AuthState.unauthenticated(error: []);

  /// EVENT
  final _eventController = StreamController<AuthEvent>();
  Sink<AuthEvent> get eventSink => _eventController.sink;

  AuthBloc({required this.authUseCase}) {
    // Trạng thái ban đầu
    _emitState(_currentState);
    _eventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(AuthEvent event) {
    event.when(
      logout: _handleLogout,
      login: _handleLogin,
    );
  }

  Future<void> _handleLogin(LoginRequest request) async {
    _emitState(const AuthState.loading());

    try {
      final result = await authUseCase.login(
        username: request.username,
        password: request.password,
      );

      result.fold(
        (fail) {
          _emitState(AuthState.unauthenticated(
            error: fail,
          ));
        },
        (response) {
          _emitState(AuthState.authenticated(
            user: response,
          ));
        },
      );
    } catch (e) {
      _emitState(const AuthState.unauthenticated(
        error: [LoginFailure.unexpected(error: 'UNEXPECTED')],
      ));
    }
  }

  void _handleLogout() {
    _emitState(const AuthState.unauthenticated(error: []));
  }

  void _emitState(AuthState newState) {
    if (!_stateController.isClosed) {
      _currentState = newState;
      _stateController.add(newState);
    }
  }

  /// Phương thức công khai để thêm sự kiện
  void add(AuthEvent event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  void dispose() {
    if (!_stateController.isClosed) _stateController.close();
    if (!_eventController.isClosed) _eventController.close();
  }
}
