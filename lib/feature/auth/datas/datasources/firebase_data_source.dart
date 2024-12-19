import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:interview_source_package/feature/auth/domains/modals/firebase_login_response.dart';
import 'package:interview_source_package/feature/auth/domains/modals/login_failure.dart';

class FirebaseDataSource implements IFirebaseDataSource {
  @override
  Future<Either<LoginFailure, FirebaseLoginResponse>> loginByFirebase({
    required String username,
    required String password,
  }) async {
    try {
      //FirebaseLogin success
      return right(const FirebaseLoginResponse(
        firebaseToken: 'firebaseToken',
      ));
    } catch (e) {
      final bool hasConnection =
          await InternetConnectionChecker().hasConnection;
      if (!hasConnection) {
        return left(const LoginFailure.noInternet());
      }

      //FirebaseLogin failure
      return left(LoginFailure.firebaseLoginError(
        error: e.toString(),
      ));
    }
  }
}

abstract class IFirebaseDataSource {
  Future<Either<LoginFailure, FirebaseLoginResponse>> loginByFirebase({
    required String username,
    required String password,
  });
}
