import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-history/controller/payment_history_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-history/view/payment_history_card.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../../../../../utils/ui/custom_button.dart';

class PaymentHistoryView extends StatefulWidget {
  const PaymentHistoryView({super.key});

  @override
  State<PaymentHistoryView> createState() => _PaymentHistoryViewState();
}

class _PaymentHistoryViewState extends State<PaymentHistoryView>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentHistoryController());

    return Obx(() {
      if (controller.isLoading.value) {
        return Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: Center(
            child: SpinKitSquareCircle(
              color: AppColors().buttonWithBackground,
              size: 50.0,
              controller: AnimationController(
                vsync: this,
                duration: const Duration(milliseconds: 1200),
              ),
            ),
          ),
        );
      }

      if (controller.errorMessage.value != null) {
        return Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Column(
            children: [
              Text(
                controller.errorMessage.value!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors().errorDialogColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 12),
              CustomButton(
                onPressed: () => controller.loadHistory(),
                text: S.of(context).retryButton,
                backgroundColor: AppColors().buttonWithBackground,
                foregroundColor: AppColors().buttonWithBackgroundText,
                textSize: 20,
                fontWeight: FontWeight.bold,
                horizontalPadding: 140,
                verticalPadding: 12,
              ),
            ],
          ),
        );
      }

      if (controller.history.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: Text(
            S.of(context).noPaymentHistory,
            style: TextStyle(
              color: AppColors().textFieldLabelColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      return Column(
        children: [
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.history.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (_, i) =>
                PaymentHistoryCard(payment: controller.history[i]),
          ),
          SizedBox(height: 18.h),
        ],
      );
    });
  }
}
