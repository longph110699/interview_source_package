// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _MainRestClient implements MainRestClient {
  _MainRestClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://000.000.00.00:000/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseResponse<BEServerLoginResponse, ErrorResponse>> login(
      {required LoginRequest loginRequest}) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = loginRequest;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResponse<BEServerLoginResponse, ErrorResponse>>(
            Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
                .compose(
                  _dio.options,
                  'account/login',
                  queryParameters: queryParameters,
                  data: _data,
                )
                .copyWith(
                    baseUrl: _combineBaseUrls(
                  _dio.options.baseUrl,
                  baseUrl,
                ))));
    final value = BaseResponse<BEServerLoginResponse, ErrorResponse>.fromJson(
      _result.data!,
      (json) => BEServerLoginResponse.fromJson(json as Map<String, dynamic>),
      (json) => ErrorResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
