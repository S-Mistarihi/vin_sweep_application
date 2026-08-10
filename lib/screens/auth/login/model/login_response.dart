import 'dart:convert';

class LoginResponse {
  final bool success;
  final int code;
  final String message;
  final Result result;

  LoginResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory LoginResponse.fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  final String accessToken;
  final String tokenType;
  final User user;

  Result({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory Result.fromRawJson(String str) => Result.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    accessToken: json["accessToken"],
    tokenType: json["tokenType"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "tokenType": tokenType,
    "user": user.toJson(),
  };
}

class User {
  final int id;
  final String fullName;
  final String email;
  final int zipCode;
  final String phoneNumber;
  final DateTime lastLogin;
  final CurrentPlan currentPlan;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.zipCode,
    required this.phoneNumber,
    required this.lastLogin,
    required this.currentPlan,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    zipCode: json["zipCode"],
    phoneNumber: json["phoneNumber"],
    lastLogin: DateTime.parse(json["lastLogin"]),
    currentPlan: CurrentPlan.fromJson(json["currentPlan"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "fullName": fullName,
    "email": email,
    "zipCode": zipCode,
    "phoneNumber": phoneNumber,
    "lastLogin": lastLogin.toIso8601String(),
    "currentPlan": currentPlan.toJson(),
  };
}

class CurrentPlan {
  final int id;
  final int userId;
  final Plan plan;
  final int reportsRemaining;
  final int generatedReportsCount;
  final DateTime startsAt;
  final DateTime expiresAt;
  final String status;
  final bool autoRenew;
  final DateTime createdAt;
  final DateTime updatedAt;

  CurrentPlan({
    required this.id,
    required this.userId,
    required this.plan,
    required this.reportsRemaining,
    required this.generatedReportsCount,
    required this.startsAt,
    required this.expiresAt,
    required this.status,
    required this.autoRenew,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CurrentPlan.fromRawJson(String str) => CurrentPlan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrentPlan.fromJson(Map<String, dynamic> json) => CurrentPlan(
    id: json["id"],
    userId: json["userId"],
    plan: Plan.fromJson(json["plan"]),
    reportsRemaining: json["reportsRemaining"],
    generatedReportsCount: json["generatedReportsCount"],
    startsAt: DateTime.parse(json["startsAt"]),
    expiresAt: DateTime.parse(json["expiresAt"]),
    status: json["status"],
    autoRenew: json["autoRenew"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "plan": plan.toJson(),
    "reportsRemaining": reportsRemaining,
    "generatedReportsCount": generatedReportsCount,
    "startsAt": startsAt.toIso8601String(),
    "expiresAt": expiresAt.toIso8601String(),
    "status": status,
    "autoRenew": autoRenew,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Plan {
  final int id;
  final String name;
  final String title;
  final String planType;
  final int price;
  final int reportPrice;
  final int reportsCount;
  final int validityDays;
  final String description;
  final bool mostPopular;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String headlinePrimary;
  final String headlineSecondary;
  final String priceLabel;
  final String priceSublabel;
  final List<String> features;
  final bool active;

  Plan({
    required this.id,
    required this.name,
    required this.title,
    required this.planType,
    required this.price,
    required this.reportPrice,
    required this.reportsCount,
    required this.validityDays,
    required this.description,
    required this.mostPopular,
    required this.createdAt,
    required this.updatedAt,
    required this.headlinePrimary,
    required this.headlineSecondary,
    required this.priceLabel,
    required this.priceSublabel,
    required this.features,
    required this.active,
  });

  factory Plan.fromRawJson(String str) => Plan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    planType: json["planType"],
    price: json["price"],
    reportPrice: json["reportPrice"],
    reportsCount: json["reportsCount"],
    validityDays: json["validityDays"],
    description: json["description"],
    mostPopular: json["mostPopular"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    headlinePrimary: json["headlinePrimary"],
    headlineSecondary: json["headlineSecondary"],
    priceLabel: json["priceLabel"],
    priceSublabel: json["priceSublabel"],
    features: List<String>.from(json["features"].map((x) => x)),
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "planType": planType,
    "price": price,
    "reportPrice": reportPrice,
    "reportsCount": reportsCount,
    "validityDays": validityDays,
    "description": description,
    "mostPopular": mostPopular,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "headlinePrimary": headlinePrimary,
    "headlineSecondary": headlineSecondary,
    "priceLabel": priceLabel,
    "priceSublabel": priceSublabel,
    "features": List<dynamic>.from(features.map((x) => x)),
    "active": active,
  };
}
