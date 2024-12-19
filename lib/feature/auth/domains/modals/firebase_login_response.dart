import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_login_response.freezed.dart';
part 'firebase_login_response.g.dart';

@freezed
class FirebaseLoginResponse with _$FirebaseLoginResponse {
  const factory FirebaseLoginResponse({
    required String firebaseToken,
  }) = _FirebaseLoginResponse;

  ///[fromJson]
  factory FirebaseLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$FirebaseLoginResponseFromJson(json);

  const FirebaseLoginResponse._();
}
