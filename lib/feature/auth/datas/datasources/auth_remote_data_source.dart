import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:interview_source_package/base/api_response_status.dart';
import 'package:interview_source_package/base/error_code.dart';
import 'package:interview_source_package/feature/auth/domains/modals/be_server_login_response.dart';
import 'package:interview_source_package/feature/auth/domains/modals/login_failure.dart';
import 'package:interview_source_package/rest_client/auth/request/login_request.dart';
import 'package:interview_source_package/rest_client/main_rest_client.dart';

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  final MainRestClient mainRestClient;
  AuthRemoteDataSource({required this.mainRestClient});

  @override
  Future<Either<LoginFailure, BEServerLoginResponse>> loginFromBEServer({
    required String username,
    required String password,
  }) async {
    try {
      final response = await mainRestClient.login(
          loginRequest: LoginRequest(
        username: username,
        password: password,
      ));

      return response.dataOption.fold(
        () {
          return response.errorOption.fold(
            () {
              return left(
                LoginFailure.unexpected(
                  error: '${BaseErrorCode.emptyResponse.valueCode} - LO-00',
                ),
              );
            },
            (e) {
              return left(
                LoginFailure.unexpected(
                  error: '${e.responseCode} - ${e.description} - LO-01',
                ),
              );
            },
          );
        },
        (result) {
          return right(result);
        },
      );
    } on DioException catch (error) {
      final bool hasConnection =
          await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        return left(const LoginFailure.noInternet());
      }

      return optionOf(error.response).fold(() {
        return left(LoginFailure.unexpected(
          error: '${BaseErrorCode.emptyResponse.valueCode} - LO-03',
        ));
      }, (a) {
        switch (a.statusCode) {
          case APIResponseStatus.unauthenticated:
            // 401
            return left(const LoginFailure.unauthenticated());

          case APIResponseStatus.unauthorized:
            // 403
            return left(const LoginFailure.unauthorized());

          case APIResponseStatus.internalServerError:
            // 500
            return left(const LoginFailure.serverError());

          default:
            // lỗi ngoại lệ
            return left(LoginFailure.unexpected(
              error:
                  '${(a.statusCode ?? 000).toString()} ${a.statusMessage ?? 'ERROR'}',
            ));
        }
      });
    } catch (e) {
      return left(LoginFailure.unexpected(error: e.toString()));
    }
  }
}

abstract class IAuthRemoteDataSource {
  Future<Either<LoginFailure, BEServerLoginResponse>> loginFromBEServer({
    required String username,
    required String password,
  });
}
