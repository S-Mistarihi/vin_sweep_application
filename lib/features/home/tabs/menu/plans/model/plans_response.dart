import 'dart:convert';

class PlansResponse {
  final bool? success;
  final int? code;
  final String? message;
  final List<PlanModel>? plans;

  PlansResponse({this.success, this.code, this.message, this.plans});

  factory PlansResponse.fromRawJson(String str) =>
      PlansResponse.fromJson(json.decode(str));

  factory PlansResponse.fromJson(Map<String, dynamic> json) => PlansResponse(
    success: json["success"],
    code: json["code"],
    message: json["message"],
    plans: json["result"] == null
        ? []
        : List<PlanModel>.from(
            json["result"]!.map((x) => PlanModel.fromJson(x)),
          ),
  );
}

class PlanModel {
  final int? id;
  final String? name;
  final String? title;
  final String? planType;
  final double? price;
  final double? reportPrice;
  final int? reportsCount;
  final int? validityDays;
  final String? description;
  final bool? mostPopular;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? headlinePrimary;
  final String? headlineSecondary;
  final String? priceLabel;
  final String? priceSublabel;
  final List<String>? features;
  final bool? active;

  PlanModel({
    this.id,
    this.name,
    this.title,
    this.planType,
    this.price,
    this.reportPrice,
    this.reportsCount,
    this.validityDays,
    this.description,
    this.mostPopular,
    this.createdAt,
    this.updatedAt,
    this.headlinePrimary,
    this.headlineSecondary,
    this.priceLabel,
    this.priceSublabel,
    this.features,
    this.active,
  });

  factory PlanModel.fromRawJson(String str) =>
      PlanModel.fromJson(json.decode(str));

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    planType: json["planType"],
    price: (json["price"] as num?)?.toDouble(),
    reportPrice: (json["reportPrice"] as num?)?.toDouble(),
    reportsCount: json["reportsCount"],
    validityDays: json["validityDays"],
    description: json["description"],
    mostPopular: json["mostPopular"],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    headlinePrimary: json["headlinePrimary"],
    headlineSecondary: json["headlineSecondary"],
    priceLabel: json["priceLabel"],
    priceSublabel: json["priceSublabel"],
    features: json["features"] == null
        ? []
        : List<String>.from(json["features"]!.map((x) => x)),
    active: json["active"],
  );
}
