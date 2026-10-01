import 'dart:convert';

import 'package:intl/intl.dart';

class PaymentHistoryResponse {
  final bool? success;
  final int? code;
  final String? message;
  final List<PayHistory>? result;

  PaymentHistoryResponse({this.success, this.code, this.message, this.result});

  factory PaymentHistoryResponse.fromRawJson(String str) =>
      PaymentHistoryResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      PaymentHistoryResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<PayHistory>.from(
                json["result"]!.map((x) => PayHistory.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result == null
        ? []
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class PayHistory {
  final int? id;
  final String? paymentIntentId;
  final double? amount;
  final String? currency;
  final String? status;
  final String? description;
  final DateTime? createdAt;
  final DateTime? confirmedAt;
  final String? discountCouponCode;
  final double? originalAmount;
  final double? discountAmount;
  final double? discountPercentage;
  final String? declineCode;
  final String? errorMessage;

  PayHistory({
    this.id,
    this.paymentIntentId,
    this.amount,
    this.currency,
    this.status,
    this.description,
    this.createdAt,
    this.confirmedAt,
    this.discountCouponCode,
    this.originalAmount,
    this.discountAmount,
    this.discountPercentage,
    this.declineCode,
    this.errorMessage,
  });

  factory PayHistory.fromRawJson(String str) =>
      PayHistory.fromJson(json.decode(str));

  factory PayHistory.fromJson(Map<String, dynamic> json) => PayHistory(
    id: json["id"],
    paymentIntentId: json["paymentIntentId"],
    amount: (json["amount"] as num?)?.toDouble(),
    currency: json["currency"],
    status: json["status"],
    description: json["description"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    confirmedAt: json["confirmedAt"] == null
        ? null
        : DateTime.parse(json["confirmedAt"]),
    discountCouponCode: json["discountCouponCode"],
    originalAmount: (json["originalAmount"] as num?)?.toDouble(),
    discountAmount: (json["discountAmount"] as num?)?.toDouble(),
    discountPercentage: (json["discountPercentage"] as num?)?.toDouble(),
    declineCode: json["declineCode"],
    errorMessage: json["errorMessage"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "paymentIntentId": paymentIntentId,
    "amount": amount,
    "currency": currency,
    "status": status,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "confirmedAt": confirmedAt?.toIso8601String(),
    "discountCouponCode": discountCouponCode,
    "originalAmount": originalAmount,
    "discountAmount": discountAmount,
    "discountPercentage": discountPercentage,
    "declineCode": declineCode,
    "errorMessage": errorMessage,
  };
}

extension PayHistoryX on PayHistory {
  String get formattedDate => createdAt == null
      ? ''
      : DateFormat('dd MMM yyyy').format(createdAt!.toLocal());

  String get formattedAmount {
    final value = amount ?? 0;
    final text = value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toStringAsFixed(2);
    final currency = (this.currency ?? '').toUpperCase();
    return currency.isEmpty ? text : '$currency $text';
  }
}
