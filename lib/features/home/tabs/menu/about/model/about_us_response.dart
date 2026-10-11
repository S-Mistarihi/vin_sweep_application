import 'dart:convert';

class AboutUsResponse {
  final bool? success;
  final int? code;
  final String? message;
  final String? result;

  AboutUsResponse({this.success, this.code, this.message, this.result});

  factory AboutUsResponse.fromRawJson(String str) =>
      AboutUsResponse.fromJson(json.decode(str));

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) =>
      AboutUsResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: json["result"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result,
  };
}
