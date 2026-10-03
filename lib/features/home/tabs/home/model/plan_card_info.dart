// forms (based design)
//   starter  : "Ends in 9 days" +  Remaining 2/5
//   basic    : "Free plan – no expiry" + Reports Bought
//   business : "Ends in 5 days" + Reports Bought
//   premium  : different header  -> Days Left + Subscription Balance + Package Balance (On Hold)
//   none / expired : additional cases (no desgin)
//
// قيم planType الفعلية من GET /plans:
//   BASIC        (Basic Plan)
//   PACKAGE      (Starter Plan)
//   SUBSCRIPTION (Business Plan) -

import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/user_plan_response.dart';

enum HomePlanVariant { none, expired, starter, basic, business, premium }

class PlanCardInfo {
  final HomePlanVariant variant;
  final String title;
  final String? subtitle;
  final int remaining; // starter
  final int total; // starter
  final int generated; // "Reports Bought"
  final int? daysLeft;
  final String? balanceLabel;

  const PlanCardInfo({
    required this.variant,
    this.title = '',
    this.subtitle,
    this.remaining = 0,
    this.total = 0,
    this.generated = 0,
    this.daysLeft,
    this.balanceLabel,
  });

  bool get isPremium => variant == HomePlanVariant.premium;

  bool get isOutOfReports =>
      variant == HomePlanVariant.starter && remaining <= 0;

  double get progress =>
      total <= 0 ? 0 : (remaining / total).clamp(0.0, 1.0).toDouble();

  String get daysLeftLabel {
    final d = daysLeft;
    if (d == null) return '';
    if (d <= 0) return 'Ends today';
    return d == 1 ? '1 Day Left' : '$d Days Left';
  }

  factory PlanCardInfo.from(UserPlanResponse? sub, {DateTime? now}) {
    now ??= DateTime.now();
    if (sub == null) return const PlanCardInfo(variant: HomePlanVariant.none);

    final plan = sub.plan;
    final title =
        plan?.headlinePrimary ?? plan?.title ?? plan?.name ?? 'Current Plan';
    final variant = _variantOf(plan);
    final end = sub.expiresAt?.toLocal();

    final expired =
        !sub.isActive ||
        (variant != HomePlanVariant.basic && end != null && end.isBefore(now));
    if (expired) {
      return PlanCardInfo(
        variant: HomePlanVariant.expired,
        title: title,
        subtitle: 'Your plan has ended',
      );
    }

    final days = end == null
        ? null
        : (end.difference(now).inMinutes / 1440).ceil();
    final generated = sub.generatedReportsCount ?? 0;

    switch (variant) {
      case HomePlanVariant.starter:
        final total = plan?.reportsCount ?? 0;
        return PlanCardInfo(
          variant: variant,
          title: title,
          subtitle: _endsIn(days),
          remaining: total > 0
              ? (sub.reportsRemaining ?? 0).clamp(0, total).toInt()
              : (sub.reportsRemaining ?? 0),
          total: total,
          generated: generated,
          daysLeft: days,
        );
      case HomePlanVariant.basic:
        return PlanCardInfo(
          variant: variant,
          title: title,
          subtitle: 'Free plan – no expiry',
          generated: generated,
        );
      case HomePlanVariant.business:
        return PlanCardInfo(
          variant: variant,
          title: title,
          subtitle: _endsIn(days),
          generated: generated,
          daysLeft: days,
        );
      case HomePlanVariant.premium:
        return PlanCardInfo(
          variant: variant,
          title: title,
          generated: generated,
          daysLeft: days,
          balanceLabel: null, // TODO(backend): رصيد الاشتراك
        );
      default:
        return const PlanCardInfo(variant: HomePlanVariant.none);
    }
  }

  static HomePlanVariant _variantOf(PlanModel? plan) {
    switch ((plan?.planType ?? '').toUpperCase()) {
      case 'BASIC':
        return HomePlanVariant.basic;
      case 'PACKAGE':
      case 'STARTER':
        return HomePlanVariant.starter;
      case 'SUBSCRIPTION':
      case 'BUSINESS':
        return HomePlanVariant.business;
      case 'PREMIUM':
        return HomePlanVariant.premium;
    }
    final validity = plan?.validityDays ?? 0;
    final count = plan?.reportsCount ?? 0;
    if (validity <= 0) return HomePlanVariant.basic;
    if (count > 0) return HomePlanVariant.starter;
    return HomePlanVariant.business;
  }

  static String? _endsIn(int? days) {
    if (days == null) return null;
    if (days <= 0) return 'Ends today';
    if (days == 1) return 'Ends in 1 day';
    return 'Ends in $days days';
  }
}
