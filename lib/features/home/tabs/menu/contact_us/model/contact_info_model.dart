import 'dart:convert';

class ContactInfoModel {
  final bool? success;
  final int? code;
  final String? message;
  final Info? result;

  ContactInfoModel({
    this.success,
    this.code,
    this.message,
    this.result,
  });

  factory ContactInfoModel.fromRawJson(String str) => ContactInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactInfoModel.fromJson(Map<String, dynamic> json) => ContactInfoModel(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    result: json["result"] == null ? null : Info.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result?.toJson(),
  };
}

class Info {
  final String? websiteUrl;
  final String? phoneNumber;
  final String? email;
  final String? instagram;
  final String? facebook;
  final String? twitter;
  final String? youtube;
  final String? tiktok;
  final String? whatsapp;

  Info({
    this.websiteUrl,
    this.phoneNumber,
    this.email,
    this.instagram,
    this.facebook,
    this.twitter,
    this.youtube,
    this.tiktok,
    this.whatsapp,
  });

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    websiteUrl: json["websiteUrl"],
    phoneNumber: json["phoneNumber"],
    email: json["email"],
    instagram: json["instagram"],
    facebook: json["facebook"],
    twitter: json["twitter"],
    youtube: json["youtube"],
    tiktok: json["tiktok"],
    whatsapp: json["whatsapp"],
  );

  Map<String, dynamic> toJson() => {
    "websiteUrl": websiteUrl,
    "phoneNumber": phoneNumber,
    "email": email,
    "instagram": instagram,
    "facebook": facebook,
    "twitter": twitter,
    "youtube": youtube,
    "tiktok": tiktok,
    "whatsapp": whatsapp,
  };
}
