enum BaseErrorCode { emptyResponse }

extension BaseErrorCodeEx on BaseErrorCode {
  String get valueCode =>
      {
        BaseErrorCode.emptyResponse: 'AVE-EmptyResponse',
      }[this] ??
      'AVE-NonDefine';
}
