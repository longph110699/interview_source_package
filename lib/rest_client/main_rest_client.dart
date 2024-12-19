import 'package:dio/dio.dart';
import 'package:interview_source_package/base/base_response.dart';
import 'package:interview_source_package/base/error_response.dart';
import 'package:interview_source_package/feature/auth/domains/modals/be_server_login_response.dart';
import 'package:interview_source_package/rest_client/auth/request/login_request.dart';
import 'package:retrofit/http.dart';

part 'main_rest_client.g.dart';

@RestApi(baseUrl: 'http://000.000.00.00:000/api/')
abstract class MainRestClient {
  factory MainRestClient(Dio dio) = _MainRestClient;

  @POST('account/login')
  Future<BaseResponse<BEServerLoginResponse, ErrorResponse>> login({
    @Body() required LoginRequest loginRequest,
  });
}
