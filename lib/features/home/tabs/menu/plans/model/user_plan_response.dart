import 'plans_response.dart';

///subscription that is returned from /plans/subscribe & /plans/confirm-payment
class UserPlanResponse {
  final int? id;
  final int? userId;
  final PlanModel? plan;
  final int? reportsRemaining;
  final int? generatedReportsCount;
  final DateTime? startsAt;
  final DateTime? expiresAt;
  final String? status;
  final bool? autoRenew;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserPlanResponse({
    this.id,
    this.userId,
    this.plan,
    this.reportsRemaining,
    this.generatedReportsCount,
    this.startsAt,
    this.expiresAt,
    this.status,
    this.autoRenew,
    this.createdAt,
    this.updatedAt,
  });

  bool get isActive => status == 'ACTIVE';

  factory UserPlanResponse.fromJson(Map<String, dynamic> json) => UserPlanResponse(
    id: json["id"],
    userId: json["userId"],
    plan: json["plan"] == null ? null : PlanModel.fromJson(json["plan"]),
    reportsRemaining: json["reportsRemaining"],
    generatedReportsCount: json["generatedReportsCount"],
    startsAt: _date(json["startsAt"]),
    expiresAt: _date(json["expiresAt"]),
    status: json["status"],
    autoRenew: json["autoRenew"],
    createdAt: _date(json["createdAt"]),
    updatedAt: _date(json["updatedAt"]),
  );

  static DateTime? _date(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());
}
