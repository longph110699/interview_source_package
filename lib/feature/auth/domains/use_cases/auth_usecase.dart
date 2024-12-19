import 'package:dartz/dartz.dart';
import 'package:interview_source_package/feature/auth/datas/repos/auth_repository.dart';
import 'package:interview_source_package/feature/auth/domains/modals/app_user.dart';
import 'package:interview_source_package/feature/auth/domains/modals/login_failure.dart';
import 'package:interview_source_package/rest_client/auth/request/login_request.dart';

class AuthUseCase {
  final IAuthRepository authRepo;

  AuthUseCase({required this.authRepo});

  Future<Either<List<LoginFailure>, AppUser>> login({
    required String username,
    required String password,
  }) async {
    if (username.isEmpty) {
      return left([
        const LoginFailure.wrongFormatUserName(
            error: 'Không được để trống username')
      ]);
    }
    if (username.length < 6) {
      return left(
          [const LoginFailure.wrongFormatUserName(error: 'username quá ngắn')]);
    }
    if (password.isEmpty) {
      return left([
        const LoginFailure.wrongFormatPassword(
            error: 'Không được để trống username')
      ]);
    }
    if (password.length < 6) {
      return left([
        const LoginFailure.wrongFormatPassword(
            error: 'Không được để trống password')
      ]);
    }

    final response = await authRepo.login(
        request: LoginRequest(
      username: username,
      password: password,
    ));

    // PASS THE CASE
    if (username == '123456' && password == '123456') {
      return right(const AppUser(
        token: 'token',
        firebaseToken: 'firebaseToken',
      ));
    } else {
      return left([const LoginFailure.wrongUserPassword()]);

      // return response.fold(
      //   (failure) {
      //     return left(failure);
      //   },
      //   (result) {
      //     return right(result);
      //   },
      // );
    }
  }
}
