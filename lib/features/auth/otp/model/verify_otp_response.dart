class VerifyOtpResponse {
  final bool? success;
  final int? code;
  final String? message;
  final VerifyOtpToken? result;

  VerifyOtpResponse({this.success, this.code, this.message, this.result});

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      VerifyOtpResponse(
        success: json['success'],
        code: json['code'],
        message: json['message'],
        result: json['result'] == null
            ? null
            : VerifyOtpToken.fromJson(json['result']),
      );
}

class VerifyOtpToken {
  final String? token;

  VerifyOtpToken({this.token});

  factory VerifyOtpToken.fromJson(Map<String, dynamic> json) =>
      VerifyOtpToken(token: json['token']);
}

enum OtpType { emailVerification, passwordReset }

extension OtpTypeApi on OtpType {
  String get apiValue {
    switch (this) {
      case OtpType.emailVerification:
        return 'EMAIL_VERIFICATION';
      case OtpType.passwordReset:
        return 'PASSWORD_RESET';
    }
  }
}
