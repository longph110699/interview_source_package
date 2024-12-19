import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:interview_source_package/feature/auth/blocs/auth_bloc.dart';
import 'package:interview_source_package/feature/auth/blocs/auth_event.dart';
import 'package:interview_source_package/feature/auth/blocs/auth_state.dart';
import 'package:interview_source_package/feature/auth/datas/datasources/auth_remote_data_source.dart';
import 'package:interview_source_package/feature/auth/datas/datasources/firebase_data_source.dart';
import 'package:interview_source_package/feature/auth/datas/repos/auth_repository.dart';
import 'package:interview_source_package/feature/auth/domains/use_cases/auth_usecase.dart';
import 'package:interview_source_package/rest_client/auth/request/login_request.dart';
import 'package:interview_source_package/rest_client/main_rest_client.dart';

class InterviewLoginScreen extends StatefulWidget {
  const InterviewLoginScreen({super.key});

  @override
  State<InterviewLoginScreen> createState() => _InterviewLoginScreenState();
}

class _InterviewLoginScreenState extends State<InterviewLoginScreen> {
  final AuthBloc authBloc = AuthBloc(
      authUseCase: AuthUseCase(
          authRepo: AuthRepository(
    remoteDataSource:
        AuthRemoteDataSource(mainRestClient: MainRestClient(Dio())),
    firebaseDataSource: FirebaseDataSource(),
  )));

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();

  StreamSubscription<AuthState>? observerAuthState;

  @override
  void initState() {
    super.initState();

    listenAuthState();
  }

  @override
  void dispose() {
    observerAuthState?.cancel();
    authBloc.dispose();
    userNameController.dispose();
    passWordController.dispose();

    super.dispose();
  }

  int rebuildInBloc = 0;
  int rebuildInOtherWidget = 0;

  @override
  Widget build(BuildContext context) {
    rebuildInOtherWidget++;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Interview Package'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            StreamBuilder<AuthState>(
              stream: authBloc.state,
              initialData: const AuthState.unauthenticated(error: []),
              builder: (context, authStateSnapshot) {
                rebuildInBloc++;
                final AuthState authState =
                    authStateSnapshot.data ?? const AuthState.loading();

                final bool isLoading = authState.maybeMap(
                  orElse: () => false,
                  loading: (_) => true,
                );

                final bool isAuthen = authState.maybeMap(
                  orElse: () => false,
                  authenticated: (_) => true,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Correct ACCOUNT and PASSWORD: 123456',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'REBUILD TRONG BLOC: $rebuildInBloc',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const SizedBox(height: 4),
                    const Text(
                      'Tài khoản',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _TextFormField(
                      controller: userNameController,
                      hintText: 'Tài khoản',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Mật khẩu',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _TextFormField(
                      controller: passWordController,
                      hintText: 'Mật khẩu',
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: isLoading
                          ? () {}
                          : isAuthen
                              ? onTapLogOut
                              : () => onTapLogin(
                                    username: userNameController.text,
                                    password: passWordController.text,
                                  ),
                      child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: isLoading
                              ? Colors.grey.shade500
                              : isAuthen
                                  ? Colors.red
                                  : Colors.blue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.blue,
                                )
                              : Text(
                                  isAuthen ? 'Logout' : 'Login',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                setState(() {});
              },
              child: Container(
                height: 48,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: const Center(
                  child: Text(
                    'setState Click',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Center(
                  child: Text(
                    'Widget này sẽ không rebuild lại khi thao tác login, logout vì không nằm trong StreamBuilder của AuthBloc SỐ LẦN REBUILD CẢ TRANG: $rebuildInOtherWidget',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void listenAuthState() {
    observerAuthState = authBloc.state.listen(
      (authState) {
        authState.map(
          loading: (_) {},
          unauthenticated: (unauth) {
            if (unauth.error.isNotEmpty) {
              showSnackBar(unauth.error.first.toString());
            }
          },
          authenticated: (auth) {
            showSnackBar('Đăng nhập thành công!');
          },
        );
      },
    );
  }

  void onTapLogin({
    required String username,
    required String password,
  }) {
    authBloc.add(AuthEvent.login(
      request: LoginRequest(
        username: username,
        password: password,
      ),
    ));
  }

  void onTapLogOut() {
    authBloc.add(const AuthEvent.logout());
  }

  void showSnackBar(String text) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        dismissDirection: DismissDirection.down,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'INFORM',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  bool? isSuccess;
  bool? isChecking;
  _TextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isSuccess,
    this.isChecking,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isChecking != null && isChecking == true
            ? Container(
                color: Colors.transparent,
                height: 12,
                width: 12,
                child: const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Colors.blue,
                  ),
                ),
              )
            : isSuccess != null
                ? isSuccess!
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      )
                : null,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
      maxLines: 1,
    );
  }
}
