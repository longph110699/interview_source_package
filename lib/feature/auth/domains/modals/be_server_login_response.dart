import 'package:freezed_annotation/freezed_annotation.dart';

part 'be_server_login_response.freezed.dart';
part 'be_server_login_response.g.dart';

@freezed
class BEServerLoginResponse with _$BEServerLoginResponse {
  const factory BEServerLoginResponse({
    required String token,
  }) = _BEServerLoginResponse;

  ///[fromJson]
  factory BEServerLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$BEServerLoginResponseFromJson(json);

  const BEServerLoginResponse._();
}
