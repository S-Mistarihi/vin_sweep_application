import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/coupon/controller/coupon_controller.dart';
import 'package:vin_sweep_application/features/plan-upgrade/review_confirmation/view/widget/payment_methods_section.dart';
import 'package:vin_sweep_application/features/reports/controller/buy_report_controller.dart';
import 'package:vin_sweep_application/features/reports/view/report_summary_card.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../coupon/view/coupon_section.dart';
import '../../coupon/view/price_breakdown_card.dart';

class BuyReportView extends StatefulWidget {
  const BuyReportView({
    super.key,
    required this.vin,
    required this.vehicleName,
  });

  final String vin;
  final String vehicleName;

  @override
  State<BuyReportView> createState() => _BuyReportViewState();
}

class _BuyReportViewState extends State<BuyReportView> {
  late final BuyReportController controller;
  late final CouponController couponController;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      BuyReportController(vin: widget.vin, vehicleName: widget.vehicleName),
    );
    couponController = Get.put(CouponController());
  }

  @override
  void dispose() {
    Get.delete<BuyReportController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: S.of(context).buyReportButton,
            leftIcon: AppAssets().backIcon,
            size: 115,
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
                          ReportSummaryCard(controller: controller),
                          const SizedBox(height: 20),
                          Obx(
                            () => controller.usesPackage
                                ? _packageNote()
                                : CouponSection(controller: couponController),
                          ),
                          const SizedBox(height: 12),
                          PriceBreakdownCard(controller: couponController),
                          const SizedBox(height: 24),
                          Obx(
                            () => controller.needsPayment
                                ? PaymentMethodsSection(controller: controller)
                                : const SizedBox.shrink(),
                          ),
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
          Obx(
            () => controller.isSubmitting.value
                ? Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black38,
                    child: Center(
                      child: SpinKitSquareCircle(
                        color: AppColors().buttonWithBackground,
                        size: 50.0,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _packageNote() {
    final p = controller.pricing.value;
    final left = p?.packageRemaining;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors().switcherBackgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors().buttonWithBackground),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'This report will be taken from your ${p?.planLabel ?? 'package'}'
              '${left != null ? ' ($left left)' : ''}. No payment needed.',
              style: TextStyle(color: AppColors().accentColor, fontSize: 14),
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
              onPressed: controller.confirm,
              text: controller.confirmLabel,
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
