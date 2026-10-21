import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/reports/model/report_pricing.dart';

import '../../../generated/l10n.dart';
import '../controller/coupon_controller.dart';

class PriceBreakdownCard extends StatelessWidget {
  const PriceBreakdownCard({super.key, required this.controller});

  final CouponController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final c = controller.coupon.value;
      if (c == null) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors().cardPlanBorder, width: 2),
        ),
        child: Column(
          children: [
            _row(
              S.of(context).originalPrice,
              ReportPricing.money(c.originalAmount),
            ),
            const SizedBox(height: 8),
            _row(
              S.of(context).discount,
              '-${ReportPricing.money(c.discountAmount)}',
              valueColor: AppColors().cardPlanCheck,
            ),
            Divider(height: 24, color: AppColors().cardPlanBorder),
            _row(
              S.of(context).total,
              ReportPricing.money(c.finalAmount),
              bold: true,
            ),
          ],
        ),
      );
    });
  }

  Widget _row(
    String label,
    String value, {
    bool bold = false,
    Color? valueColor,
  }) {
    final style = TextStyle(
      color: AppColors().accentColor,
      fontSize: bold ? 18 : 15,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    );
    return Row(
      children: [
        Text(label, style: style),
        const Spacer(),
        Text(value, style: style.copyWith(color: valueColor)),
      ],
    );
  }
}
