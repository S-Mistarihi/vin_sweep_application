import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/utils/ui/shimmer_box.dart';

class PaymentMethodsSkeleton extends StatelessWidget {
  const PaymentMethodsSkeleton({super.key, this.count = 3});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < count; i++) ...[
          PaymentMethodCardSkeleton(showDefault: i == 0),
          if (i != count - 1) const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class PaymentMethodCardSkeleton extends StatelessWidget {
  const PaymentMethodCardSkeleton({super.key, this.showDefault = false});

  final bool showDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors().baseColor,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: AppColors().switcherBackgroundColor),
      ),
      child: ShimmerScope(
        child: Row(
          children: [
            const ShimmerBox(width: 46, height: 46, radius: 12), // أيقونة الكرت
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerBox(width: 90, height: 14), // اسم الكرت
                  const SizedBox(height: 13),
                  const ShimmerBox(width: 150, height: 18), // الرقم المخفي
                  if (showDefault) ...[
                    const SizedBox(height: 12),
                    const ShimmerBox(width: 50, height: 12), // Default
                  ] else
                    const SizedBox(height: 6),
                ],
              ),
            ),
            const ShimmerBox(width: 6, height: 24, radius: 3), // أيقونة القائمة
          ],
        ),
      ),
    );
  }
}
