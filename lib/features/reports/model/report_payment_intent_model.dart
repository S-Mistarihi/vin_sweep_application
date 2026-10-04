import 'dart:convert';

class ReportPaymentIntentModel {
  final bool success;
  final int code;
  final String message;
  final ReportPaymentIntent result;

  ReportPaymentIntentModel({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory ReportPaymentIntentModel.fromRawJson(String str) =>
      ReportPaymentIntentModel.fromJson(json.decode(str));

  factory ReportPaymentIntentModel.fromJson(Map<String, dynamic> json) =>
      ReportPaymentIntentModel(
        success: json["success"]??'',
        code: json["code"]??0,
        message: json["message"]??'',
        result: ReportPaymentIntent.fromJson(json["result"]),
      );
}

class ReportPaymentIntent {
  final String paymentIntentId;
  final String clientSecret;
  final String vin;
  final String planType;
  final bool requiresPayment;
  final String message;

  const ReportPaymentIntent({
    required this.paymentIntentId,
    required this.clientSecret,
    required this.vin,
    required this.planType,
    required this.requiresPayment,
    required this.message,
  });

  factory ReportPaymentIntent.fromJson(Map<String, dynamic> json) =>
      ReportPaymentIntent(
        paymentIntentId: (json['paymentIntentId'] ?? '').toString(),
        clientSecret: (json['clientSecret'] ?? '').toString(),
        vin: (json['vin'] ?? '').toString(),
        planType: (json['planType'] ?? '').toString(),
        requiresPayment: json['requiresPayment'] != false,
        message: (json['message'] ?? '').toString(),
      );
}
