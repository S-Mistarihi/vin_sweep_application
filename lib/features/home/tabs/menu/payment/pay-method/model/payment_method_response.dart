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
        success: json["success"] ?? false,
        code: json["code"] ?? 0,
        message: json["message"] ?? '',
        result: (json["result"] as List? ?? [])
            .map((x) => PayMethod.fromJson(x as Map<String, dynamic>))
            .toList(),
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
    paymentMethodId: json["paymentMethodId"] ?? '',
    type: json["type"] ?? '',
    displayName: json["displayName"] ?? '',
    metadata: json["metadata"] ?? '',
    expired: json["expired"] ?? false,
    resultDefault: json["default"] ?? false,
  );
}

extension PayMethodX on PayMethod {
  /// **** **** **** 1234
  /// اسأل الباك وين آخر 4 أرقام: بالـ metadata ولا بالـ displayName
  String get maskedNumber {
    final source = metadata.isNotEmpty ? metadata : displayName;
    final digits = source.replaceAll(RegExp(r'\D'), '');
    final last4 = digits.length >= 4
        ? digits.substring(digits.length - 4)
        : digits;
    return '**** **** **** $last4';
  }
}
