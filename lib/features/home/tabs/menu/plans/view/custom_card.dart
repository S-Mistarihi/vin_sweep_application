import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../../../../generated/l10n.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.plan,
    required this.isCurrentPlan,
    required this.isAutoRenew,
    required this.onAutoRenewChanged,
    required this.onCancel,
    required this.onUpgrade,
  });

  final PlanModel plan;

  /// true: user current plan(Auto Renew + Cancel Plan)
  /// false: other plan (Upgrade plan)
  final bool isCurrentPlan;
  final bool isAutoRenew;
  final ValueChanged<bool> onAutoRenewChanged;
  final VoidCallback onCancel;
  final VoidCallback onUpgrade;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors().baseColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors().cardPlanBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors().cardPlanShadow,
                  offset: Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 2.h),
                  _buildHeader(),
                  SizedBox(height: 7),
                  SvgPicture.asset(AppAssets().seperator),
                  SizedBox(height: 18),
                  ...(plan.features ?? []).map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: _buildcardFeatures(text: f),
                    ),
                  ),
                  if (isCurrentPlan) ...[
                    SvgPicture.asset(AppAssets().seperator),
                    SizedBox(height: 23),
                    _buildSwitcherButton(context),
                    SizedBox(height: 1.h),
                    SizedBox(
                      width: 100.w,
                      child: CustomButton(
                        onPressed: onCancel,
                        text: S.of(context).cancelPlanButton,
                        backgroundColor: Colors.transparent,
                        foregroundColor: AppColors().textFieldLabelColor,
                        textSize: 20,
                        fontWeight: FontWeight.bold,
                        horizontalPadding: 73,
                        verticalPadding: 12,
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ] else ...[
                    SizedBox(height: 1.h),
                    SizedBox(
                      width: 100.w,
                      child: CustomButton(
                        onPressed: onUpgrade,
                        text: S.of(context).upgradeButton,
                        backgroundColor: AppColors().buttonWithBackground,
                        foregroundColor: AppColors().buttonWithBackgroundText,
                        textSize: 20,
                        fontWeight: FontWeight.bold,
                        horizontalPadding: 73,
                        verticalPadding: 12,
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ],
              ),
            ),
          ),
          if (plan.mostPopular == true) _buildMostPopularPart(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                plan.headlinePrimary ?? '',
                style: TextStyle(color: AppColors().accentColor, fontSize: 20),
              ),
              SizedBox(height: 6),
              Text(
                plan.headlineSecondary ?? '',
                style: TextStyle(color: AppColors().cardPlanText, fontSize: 14),
              ),
            ],
          ),
        ),
        Spacer(),
        Column(
          children: [
            Text(
              plan.priceLabel ?? '\$${plan.price ?? 0}',
              style: TextStyle(
                color: AppColors().accentColor,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              plan.priceSublabel ?? '',
              style: TextStyle(color: AppColors().subIntroText, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildcardFeatures({required String text}) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors().cardPlanCheck,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.5, horizontal: 5.5),
            child: Icon(Icons.check, color: AppColors().baseColor, size: 18),
          ),
        ),
        SizedBox(width: 18),
        Expanded(
          child: Text(
            text,
            overflow: TextOverflow.visible,
            style: TextStyle(color: AppColors().accentColor, fontSize: 18),
          ),
        ),
      ],
    );
  }

  Row _buildSwitcherButton(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).autoRenweSwitch,
          style: TextStyle(color: AppColors().accentColor, fontSize: 16),
        ),
        Spacer(),
        Switch(
          value: isAutoRenew,
          onChanged: onAutoRenewChanged,
          inactiveTrackColor: AppColors().inactiveTrackSwitchColor,
          inactiveThumbColor: AppColors().baseColor,
          activeTrackColor: AppColors().firstHeaderShadowColor,
          activeThumbColor: AppColors().baseColor,
        ),
      ],
    );
  }

  Positioned _buildMostPopularPart(BuildContext context) {
    return Positioned(
      top: -36,
      right: 17,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors().cardPopularBack,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Text(
          S.of(context).mostPopularPart,
          style: TextStyle(color: AppColors().baseColor, fontSize: 15),
        ),
      ),
    );
  }
}
