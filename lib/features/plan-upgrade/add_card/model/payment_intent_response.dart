import 'dart:convert';

class PaymentIntentResponse {
  final bool success;
  final int code;
  final String message;
  final SetupIntentData result;

  PaymentIntentResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory PaymentIntentResponse.fromRawJson(String str) =>
      PaymentIntentResponse.fromJson(json.decode(str));

  factory PaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentIntentResponse(
        success: json["success"] ?? false,
        code: json["code"] ?? 0,
        message: json["message"] ?? '',
        result: SetupIntentData.fromJson(
          (json["result"] as Map<String, dynamic>?) ?? {},
        ),
      );
}

class SetupIntentData {
  final String setupIntentId;
  final String clientSecret;

  SetupIntentData({required this.setupIntentId, required this.clientSecret});

  factory SetupIntentData.fromRawJson(String str) =>
      SetupIntentData.fromJson(json.decode(str));

  factory SetupIntentData.fromJson(Map<String, dynamic> json) =>
      SetupIntentData(
        setupIntentId: json["setupIntentId"] ?? '',
        clientSecret: json["clientSecret"] ?? '',
      );
}
