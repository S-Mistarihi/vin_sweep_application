import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/coupon/controller/coupon_controller.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';
import 'package:vin_sweep_application/utils/ui/custom_text_field.dart';

import '../../../generated/l10n.dart';

class CouponSection extends StatelessWidget {
  const CouponSection({super.key, required this.controller});

  final CouponController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final applied = controller.coupon.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).discountCoupon,
            style: TextStyle(
              color: AppColors().accentColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          if (applied != null)
            _appliedChip(applied.couponCode, applied.discountPercentage)
          else
            Row(
              children: [
                Expanded(
                  child: CustomTextField().buildCustomTextField(
                    controller: controller.couponText,
                    onSubmitted: (_) => controller.applyCoupon(),
                    textCapitalization: TextCapitalization.characters,
                    hintText: S.of(context).enterCouponCode,
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 48,
                  child: CustomButton(
                    onPressed: controller.isApplyingCoupon.value
                        ? null
                        : controller.applyCoupon,
                    text: S.of(context).apply,
                    backgroundColor: AppColors().buttonWithBackground,
                    foregroundColor: AppColors().buttonWithBackgroundText,
                    textSize: 16,
                    fontWeight: FontWeight.bold,
                    horizontalPadding: 22,
                    verticalPadding: 10,
                  ),
                ),
              ],
            ),
          if (controller.couponError.value != null)
            Padding(
              padding: const EdgeInsets.only(top: 6, left: 8),
              child: Text(
                controller.couponError.value!,
                style: TextStyle(color: AppColors().errorText, fontSize: 13),
              ),
            ),
        ],
      );
    });
  }

  Widget _appliedChip(String code, double percentage) {
    final pct = percentage > 0
        ? ' • ${percentage.toStringAsFixed(0)}% off'
        : '';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors().successDialogColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors().cardPlanCheck, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              '$code applied$pct',
              style: TextStyle(
                color: AppColors().accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: controller.removeCoupon,
            child: Icon(Icons.close, color: AppColors().accentColor, size: 20),
          ),
        ],
      ),
    );
  }
}
