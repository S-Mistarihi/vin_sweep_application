import 'dart:convert';

class PlanPaymentIntentResponse {
  final bool success;
  final int code;
  final String message;
  final PaymentIntentData result;

  PlanPaymentIntentResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory PlanPaymentIntentResponse.fromRawJson(String str) =>
      PlanPaymentIntentResponse.fromJson(json.decode(str));

  factory PlanPaymentIntentResponse.fromJson(Map<String, dynamic> json) =>
      PlanPaymentIntentResponse(
        success: json["success"] ?? false,
        code: json["code"] ?? 0,
        message: json["message"] ?? '',
        result: PaymentIntentData.fromJson(
          (json["result"] as Map<String, dynamic>?) ?? {},
        ),
      );
}

class PaymentIntentData {
  final String paymentIntentId;
  final String clientSecret;
  final String message;

  PaymentIntentData({
    required this.paymentIntentId,
    required this.clientSecret,
    required this.message,
  });

  factory PaymentIntentData.fromRawJson(String str) =>
      PaymentIntentData.fromJson(json.decode(str));

  factory PaymentIntentData.fromJson(Map<String, dynamic> json) =>
      PaymentIntentData(
        paymentIntentId: json["paymentIntentId"] ?? '',
        clientSecret: json["clientSecret"] ?? '',
        message: json["message"] ?? '',
      );
}
