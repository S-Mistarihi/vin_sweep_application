import 'dart:convert';

class CouponResponse {
  final bool success;
  final int code;
  final String message;
  final CouponResult result;

  CouponResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory CouponResponse.fromRawJson(String str) =>
      CouponResponse.fromJson(json.decode(str));

  factory CouponResponse.fromJson(Map<String, dynamic> json) => CouponResponse(
    success: json["success"] ?? false,
    code: json["code"] ?? 0,
    message: json["message"] ?? '',
    result: CouponResult.fromJson(json["result"]),
  );
}

class CouponResult {
  final String couponCode;
  final double originalAmount;
  final double discountAmount;
  final double finalAmount;
  final double discountPercentage;
  final bool applied;
  final String message;

  const CouponResult({
    required this.couponCode,
    required this.originalAmount,
    required this.discountAmount,
    required this.finalAmount,
    required this.discountPercentage,
    required this.applied,
    required this.message,
  });

  factory CouponResult.fromJson(Map<String, dynamic> json) => CouponResult(
    couponCode: (json['couponCode'] ?? '').toString(),
    originalAmount: (json['originalAmount'] as num?)?.toDouble() ?? 0,
    discountAmount: (json['discountAmount'] as num?)?.toDouble() ?? 0,
    finalAmount: (json['finalAmount'] as num?)?.toDouble() ?? 0,
    discountPercentage: (json['discountPercentage'] as num?)?.toDouble() ?? 0,
    applied: json['applied'] == true,
    message: (json['message'] ?? '').toString(),
  );
}
