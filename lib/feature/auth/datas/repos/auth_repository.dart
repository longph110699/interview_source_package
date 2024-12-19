import 'package:dartz/dartz.dart';
import 'package:interview_source_package/feature/auth/datas/datasources/auth_remote_data_source.dart';
import 'package:interview_source_package/feature/auth/datas/datasources/firebase_data_source.dart';
import 'package:interview_source_package/feature/auth/domains/modals/app_user.dart';
import 'package:interview_source_package/feature/auth/domains/modals/login_failure.dart';
import 'package:interview_source_package/rest_client/auth/request/login_request.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDataSource remoteDataSource;
  final IFirebaseDataSource firebaseDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.firebaseDataSource,
  });

  @override
  Future<Either<List<LoginFailure>, AppUser>> login({
    required LoginRequest request,
  }) async {
    final List<LoginFailure> listFailure = [];
    String? firebaseToken;
    String? beToken;

    final responseLoginFromBEServer = await remoteDataSource.loginFromBEServer(
      username: request.username,
      password: request.password,
    );

    final responseLoginFromFirebase = await firebaseDataSource.loginByFirebase(
      username: request.username,
      password: request.password,
    );

    responseLoginFromBEServer.fold(
      (failure) {
        listFailure.add(failure);
      },
      (result) {
        beToken = result.token;
      },
    );

    responseLoginFromFirebase.fold(
      (failure) {
        listFailure.add(failure);
      },
      (result) {
        firebaseToken = result.firebaseToken;
      },
    );

    final bool loginSuccessFromBE = beToken != null && beToken!.isNotEmpty;
    final bool loginSuccessFromFirebase =
        firebaseToken != null && firebaseToken!.isNotEmpty;
    final bool isEmptyError = listFailure.isEmpty;
    final bool isSucessAndGotResult =
        loginSuccessFromBE && loginSuccessFromFirebase && isEmptyError;

    if (isSucessAndGotResult) {
      return right(AppUser(
        token: beToken,
        firebaseToken: firebaseToken,
      ));
    } else {
      return left(listFailure);
    }
  }
}

abstract class IAuthRepository {
  Future<Either<List<LoginFailure>, AppUser>> login({
    required LoginRequest request,
  });
}
