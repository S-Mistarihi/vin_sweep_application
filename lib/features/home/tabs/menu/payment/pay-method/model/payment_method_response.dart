import 'dart:convert';

class PaymentMethodResponse {
  final bool success;
  final int code;
  final String message;
  final List<PayMethod> result;

  PaymentMethodResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory PaymentMethodResponse.fromRawJson(String str) =>
      PaymentMethodResponse.fromJson(json.decode(str));

  factory PaymentMethodResponse.fromJson(Map<String, dynamic> json) =>
      PaymentMethodResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: List<PayMethod>.from(
          json["result"].map((x) => PayMethod.fromJson(x)),
        ),
      );
}

class PayMethod {
  final String paymentMethodId;
  final String type;
  final String displayName;
  final String metadata;
  final bool expired;
  final bool resultDefault;

  PayMethod({
    required this.paymentMethodId,
    required this.type,
    required this.displayName,
    required this.metadata,
    required this.expired,
    required this.resultDefault,
  });

  factory PayMethod.fromRawJson(String str) =>
      PayMethod.fromJson(json.decode(str));

  factory PayMethod.fromJson(Map<String, dynamic> json) => PayMethod(
    paymentMethodId: json["paymentMethodId"],
    type: json["type"],
    displayName: json["displayName"],
    metadata: json["metadata"],
    expired: json["expired"],
    resultDefault: json["default"],
  );
}
