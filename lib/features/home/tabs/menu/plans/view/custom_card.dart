import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.plan,
    required this.isAutoRenew,
    required this.onAutoRenewChanged,
    required this.index,
  });

  final PlanModel plan;
  final bool isAutoRenew;
  final ValueChanged<bool> onAutoRenewChanged;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 375,
            decoration: BoxDecoration(
              color: AppColors().baseColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors().cardPlanBorder),
              boxShadow: [
                BoxShadow(
                  color: AppColors().cardPlanShadow,
                  offset: Offset(0, 7),
                  blurRadius: 11,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plan.headlinePrimary ?? '',
                            style: TextStyle(
                              color: AppColors().accentColor,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            plan.headlineSecondary ?? '',
                            style: TextStyle(
                              color: AppColors().cardPlanText,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            plan.priceLabel ?? '\$${plan.price ?? 0}',
                            style: TextStyle(
                              color: AppColors().accentColor,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            plan.priceSublabel ?? '',
                            style: TextStyle(
                              color: AppColors().subIntroText,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  SvgPicture.asset(AppAssets().seperator),
                  SizedBox(height: 18),
                  _buildcardFeatures(text: plan.features![0]),
                  SizedBox(height: 18),
                  _buildcardFeatures(text: plan.features![1]),
                  SizedBox(height: 18),
                  _buildcardFeatures(text: plan.features![2]),
                  SizedBox(height: 18),
                  _buildcardFeatures(text: plan.features![3]),
                  SizedBox(height: 18),
                  if (index == 0) ...[
                    SvgPicture.asset(AppAssets().seperator),
                    SizedBox(height: 23),
                    _buildSwitcherButton(),
                    SizedBox(height: 2.h),
                    SizedBox(
                      width: 100.w,
                      child: CustomButton(
                        onPressed: () {},
                        text: 'Cancel',
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
                        onPressed: () {},
                        text: 'Upgrade',
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
          if (index == 1) _buildMostPopularPart(),
        ],
      ),
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
            child: Icon(Icons.check, color: AppColors().baseColor, size: 20),
          ),
        ),
        SizedBox(width: 18),
        Text(
          text,
          overflow: TextOverflow.visible,
          style: TextStyle(color: AppColors().accentColor, fontSize: 20),
        ),
      ],
    );
  }

  Row _buildSwitcherButton() {
    return Row(
      children: [
        Text(
          'Auto Renwel',
          style: TextStyle(color: AppColors().accentColor, fontSize: 18),
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

  Positioned _buildMostPopularPart() {
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
          'Most Popular',
          style: TextStyle(color: AppColors().baseColor, fontSize: 15),
        ),
      ),
    );
  }
}
