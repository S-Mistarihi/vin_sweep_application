import 'dart:convert';

class LoginResponse {
  final bool? success;
  final int? code;
  final String? message;
  final UserModel? user;

  LoginResponse({this.success, this.code, this.message, this.user});

  factory LoginResponse.fromRawJson(String str) =>
      LoginResponse.fromJson(json.decode(str));

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json['success'],
    code: json['code'],
    message: json['message'],
    user: json['result'] == null ? null : UserModel.fromJson(json['result']),
  );
}

class UserModel {
  final String? accessToken;
  final String? tokenType;
  final User? user;

  UserModel({this.accessToken, this.tokenType, this.user});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    accessToken: json['accessToken'],
    tokenType: json['tokenType'],
    user: json['user'] == null ? null : User.fromJson(json['user']),
  );
}

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final int? zipCode;
  final dynamic phoneNumber;
  final String? lastLogin;
  //final CurrentPlan? currentPlan;

  User({
    this.id,
    this.fullName,
    this.email,
    this.zipCode,
    this.phoneNumber,
    this.lastLogin,
    //this.currentPlan,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    fullName: json['fullName'],
    email: json['email'],
    zipCode: json['zipCode'],
    phoneNumber: json["phoneNumber"],
    lastLogin: json["lastLogin"],
  //   currentPlan: json["currentPlan"] == null
  //       ? null
  //       : CurrentPlan.fromJson(json["currentPlan"]),
   );
}

// class CurrentPlan {
//   final int? id;
//   final int? userId;
//   final Plan? plan;
//   final int? reportsRemaining;
//   final int? generatedReportsCount;
//   final String? startsAt;
//   final dynamic expiresAt;
//   final String? status;
//   final bool? autoRenew;
//   final String? createdAt;
//   final String? updatedAt;
//
//   CurrentPlan({
//     this.id,
//     this.userId,
//     this.plan,
//     this.reportsRemaining,
//     this.generatedReportsCount,
//     this.startsAt,
//     this.expiresAt,
//     this.status,
//     this.autoRenew,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory CurrentPlan.fromRawJson(String str) =>
//       CurrentPlan.fromJson(json.decode(str));
//
//   factory CurrentPlan.fromJson(Map<String, dynamic> json) => CurrentPlan(
//     id: json["id"],
//     userId: json["userId"],
//     plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
//     reportsRemaining: json["reportsRemaining"],
//     generatedReportsCount: json["generatedReportsCount"],
//     startsAt: json["startsAt"],
//     expiresAt: json["expiresAt"],
//     status: json["status"],
//     autoRenew: json["autoRenew"],
//     createdAt: json["createdAt"],
//     updatedAt: json["updatedAt"],
//   );
// }
//
// class Plan {
//   final int? id;
//   final String? name;
//   final String? title;
//   final String? planType;
//   final int? price;
//   final int? reportPrice;
//   final int? reportsCount;
//   final int? validityDays;
//   final String? description;
//   final bool? mostPopular;
//   final String? createdAt;
//   final String? updatedAt;
//   final String? headlinePrimary;
//   final String? headlineSecondary;
//   final String? priceLabel;
//   final String? priceSublabel;
//   final List<String>? features;
//   final bool? active;
//
//   Plan({
//     this.id,
//     this.name,
//     this.title,
//     this.planType,
//     this.price,
//     this.reportPrice,
//     this.reportsCount,
//     this.validityDays,
//     this.description,
//     this.mostPopular,
//     this.createdAt,
//     this.updatedAt,
//     this.headlinePrimary,
//     this.headlineSecondary,
//     this.priceLabel,
//     this.priceSublabel,
//     this.features,
//     this.active,
//   });
//
//   factory Plan.fromRawJson(String str) => Plan.fromJson(json.decode(str));
//
//   factory Plan.fromJson(Map<String, dynamic> json) => Plan(
//     id: json["id"],
//     name: json["name"],
//     title: json["title"],
//     planType: json["planType"],
//     price: json["price"],
//     reportPrice: json["reportPrice"],
//     reportsCount: json["reportsCount"],
//     validityDays: json["validityDays"],
//     description: json["description"],
//     mostPopular: json["mostPopular"],
//     createdAt: json["createdAt"],
//     updatedAt: json["updatedAt"],
//     headlinePrimary: json["headlinePrimary"],
//     headlineSecondary: json["headlineSecondary"],
//     priceLabel: json["priceLabel"],
//     priceSublabel: json["priceSublabel"],
//     features: List<String>.from(json["features"].map((x) => x)),
//     active: json["active"],
//   );
// }
