import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';

class ReportPricing {
  /// null = because if we cannot determine price, we assume payment is required
  final double? amount;
  final bool usesPackage;
  final int? packageRemaining;
  final String planLabel;
  final bool directGenerate;

  const ReportPricing({
    this.amount,
    this.usesPackage = false,
    this.packageRemaining,
    this.planLabel = '',
    this.directGenerate = false,
  });

  factory ReportPricing.from({
    UserPlanResponse? sub,
    List<PlanModel> plans = const [],
  }) {
    final plan = sub?.plan;
    final type = (plan?.planType ?? '').toUpperCase();
    final active = sub != null && sub.isActive;

    // plan with credit: no payment required
    if (active && type == 'PACKAGE' && (sub.reportsRemaining ?? 0) > 0) {
      return ReportPricing(
        amount: 0,
        usesPackage: true,
        packageRemaining: sub.reportsRemaining,
        directGenerate: true,
        planLabel: plan?.headlinePrimary ?? plan?.name ?? 'Package',
      );
    }

    //subscription: report price based on the plan
    if (active && type == 'SUBSCRIPTION') {
      return ReportPricing(
        amount: plan?.reportPrice,
        planLabel: plan?.headlinePrimary ?? plan?.name ?? 'Subscription',
        directGenerate: true,
      );
    }

    final basic = plans
        .where((p) => (p.planType ?? '').toUpperCase() == 'BASIC')
        .firstOrNull;
    return ReportPricing(
      amount:
          basic?.reportPrice ?? (type == 'BASIC' ? plan?.reportPrice : null),
      planLabel: 'Pay per report',
    );
  }

  static String money(double v) => v == v.roundToDouble()
      ? '\$${v.toStringAsFixed(0)}'
      : '\$${v.toStringAsFixed(2)}';
}
