import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-history/view/payment_history.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/view/payment_method.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/payment_controller.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';

import '../../../../../configuration/app_assets.dart';
import '../../../../../configuration/app_colors.dart';
import '../../../../../utils/ui/custom_button.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            CustomMainHeader(
              headerSpace: 25,
              size: 105,
              headerMainText: 'Payments Info',
              leftIcon: AppAssets().backIcon,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildAuthSwitcher(context, controller),
                      controller.isPayMethod
                          ? PaymentMethod()
                          : PaymentHistory(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 86.h,
              right: 6.w,
              left: 6.w,
              bottom: 4.h,
              child: Column(
                children: [
                  CustomButton(
                    onPressed: () {
                      // if (_key.currentState!.validate()) {
                      //   controller.onChangePressed();
                      // }
                    },
                    text: 'Add Payment Method',
                    backgroundColor: AppColors().buttonWithBackground,
                    foregroundColor: AppColors().buttonWithBackgroundText,
                    textSize: 20,
                    fontWeight: FontWeight.bold,
                    horizontalPadding: 100,
                    verticalPadding: 12,
                  ),
                  SizedBox(height: 3.h),
                  SvgPicture.asset(
                    AppAssets().copyRightIcon,
                    width: 212,
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthSwitcher(
    BuildContext context,
    PaymentController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
      decoration: BoxDecoration(
        color: AppColors().switcherBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: controller.isPayMethod
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: 43.w,
              height: 4.5.h,
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: controller.switchToMethod,
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      'Payment Methods',
                      style: TextStyle(
                        color: AppColors().accentColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: controller.switchToHistory,
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      'Payment History',
                      style: TextStyle(
                        color: AppColors().accentColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
