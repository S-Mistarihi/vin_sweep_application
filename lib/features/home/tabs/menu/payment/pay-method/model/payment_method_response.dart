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
  /// {"last4":"4242","expMonth":12,"expYear":2035,"brand":"visa",...}
  String get last4 {
    try {
      final m = jsonDecode(metadata);
      if (m is Map && m['last4'] != null) return m['last4'].toString();
    } catch (_) {}

    final digits = displayName.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 4 ? digits.substring(digits.length - 4) : digits;
  }

  /// **** **** **** 4242
  String get maskedNumber => '**** **** **** $last4';
}
