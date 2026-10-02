import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/plan-upgrade/review_confirmation/view/widget/payment_methods_section.dart';
import 'package:vin_sweep_application/features/plan-upgrade/review_confirmation/view/widget/plan_summary_card.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../home/tabs/menu/plans/model/plans_response.dart';
import '../controller/review_confirmation_controller.dart';

class ReviewConfirmationView extends StatefulWidget {
  const ReviewConfirmationView({super.key, required this.plan});

  final PlanModel plan;

  @override
  State<ReviewConfirmationView> createState() => _ReviewConfirmationViewState();
}

class _ReviewConfirmationViewState extends State<ReviewConfirmationView> {
  late final ReviewConfirmationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ReviewConfirmationController(widget.plan));
  }

  @override
  void dispose() {
    Get.delete<ReviewConfirmationController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: S.of(context).reviewConfirmation,
            leftIcon: AppAssets().backIcon,
            size: 65,
          ),
          Positioned(
            top: 13.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 100.w,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 30),
                          PlanSummaryCard(plan: widget.plan),
                          const SizedBox(height: 24),
                          PaymentMethodsSection(controller: controller),
                          const SizedBox(height: 16),
                          _buildTerms(),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  _buildButtons(),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTerms() {
    return Obx(
      () => Row(
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: controller.acceptTerms.value,
              onChanged: controller.toggleTerms,
              activeColor: AppColors().cardCheckedBox,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            S.of(context).acceptTermsAndConditions,
            style: TextStyle(
              color: AppColors().accentColor,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: () => Get.back(),
            text: S.of(context).cancelButton,
            backgroundColor: AppColors().buttonWithoutBackground,
            foregroundColor: AppColors().buttonWithoutBackgroundText,
            textSize: 20,
            fontWeight: FontWeight.normal,
            horizontalPadding: 60,
            verticalPadding: 13,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Obx(
            () => CustomButton(
              onPressed: controller.canConfirm ? controller.confirm : null,
              text: 'Confirm',
              backgroundColor: AppColors().buttonWithBackground,
              foregroundColor: AppColors().buttonWithBackgroundText,
              textSize: 20,
              fontWeight: FontWeight.normal,
              horizontalPadding: 60,
              verticalPadding: 13,
            ),
          ),
        ),
      ],
    );
  }
}
