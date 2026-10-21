import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../../../../../generated/l10n.dart';

class PlanListCard extends StatelessWidget {
  const PlanListCard({
    super.key,
    required this.plan,
    required this.isCurrent,
    required this.onSelect,
  });

  final PlanModel plan;
  final bool isCurrent;
  final VoidCallback onSelect;

  static const double badgeHeight = 36;

  @override
  Widget build(BuildContext context) {
    final dark = isCurrent;
    final textColor = dark ? AppColors().baseColor : AppColors().accentColor;

    return Padding(
      padding: EdgeInsets.only(top: plan.mostPopular == true ? badgeHeight : 0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 100.w,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            decoration: BoxDecoration(
              color: dark
                  ? AppColors().buttonWithBackground
                  : AppColors().allPlanBg,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: dark
                    ? AppColors().buttonWithBackground
                    : AppColors().cardPlanBorder,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(textColor, dark),
                const SizedBox(height: 12),
                Divider(
                  height: 1,
                  color: dark
                      ? AppColors().baseColor
                      : AppColors().cardPlanBorder,
                ),
                const SizedBox(height: 14),
                ...(plan.features ?? []).map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _feature(f, textColor),
                  ),
                ),
                const SizedBox(height: 6),
                _button(context, dark),
              ],
            ),
          ),
          if (plan.mostPopular == true)
            Positioned(
              top: -badgeHeight,
              right: 17,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors().cardPopularBack,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Text(
                  S.of(context).mostPopularPart,
                  style: TextStyle(color: AppColors().baseColor, fontSize: 14),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _header(Color textColor, bool dark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.headlinePrimary ?? plan.name ?? '',
                style: TextStyle(color: textColor, fontSize: 18),
              ),
              const SizedBox(height: 6),
              Text(
                plan.headlineSecondary ?? '',
                style: TextStyle(
                  color: dark
                      ? AppColors().baseColor
                      : AppColors().cardPlanText,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              plan.priceLabel ?? '\$${plan.price ?? 0}',
              style: TextStyle(
                color: textColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            if ((plan.priceSublabel ?? '').isNotEmpty)
              Text(
                plan.priceSublabel!,
                style: TextStyle(
                  color: dark
                      ? AppColors().baseColor
                      : AppColors().cardPlanText,
                  fontSize: 13,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _feature(String text, Color textColor) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: AppColors().cardPlanCheck,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.check, color: AppColors().baseColor, size: 15),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: TextStyle(color: textColor, fontSize: 14)),
        ),
      ],
    );
  }

  Widget _button(BuildContext context, bool dark) {
    return SizedBox(
      width: 100.w,
      height: 48,
      child: dark
          ? CustomButton(
              onPressed: null,
              text: S.of(context).currentPlan,
              backgroundColor: AppColors().baseColor.withOpacity(.2),
              foregroundColor: AppColors().baseColor,
              textSize: 20,
              fontWeight: FontWeight.bold,
              horizontalPadding: 95,
              verticalPadding: 12,
            )
          : CustomButton(
              onPressed: onSelect,
              text: plan.planType == 'BASIC'
                  ? S.of(context).select
                  : S.of(context).upgrade,
              backgroundColor: AppColors().buttonWithoutBackground,
              foregroundColor: AppColors().buttonWithoutBackgroundText,
              textSize: 20,
              fontWeight: FontWeight.bold,
              horizontalPadding: 110,
              verticalPadding: 12,
            ),
    );
  }
}
