import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/controller/payment_method_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/view/payment_method_card.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../../../../../generated/l10n.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PaymentMethodController());

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
                onPressed: () => controller.loadMethods(),
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

      if (controller.methods.isEmpty) {
        return Padding(
          padding: EdgeInsets.only(top: 25.h),
          child: Text(
            S.of(context).noPaymentMethods,
            style: TextStyle(
              color: AppColors().textFieldLabelColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(height: 24),
          // Text(
          //   'Select Default',
          //   style: TextStyle(
          //     color: AppColors().buttonWithBackground,
          //     fontSize: 16,
          //   ),
          // ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.methods.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (_, i) {
              final method = controller.methods[i];
              return PaymentMethodCard(
                method: method,
                onSetDefault: () => controller.setDefault(method),
                onDelete: () => controller.deleteMethod(method),
              );
            },
          ),
          SizedBox(height: 18.h),
        ],
      );
    });
  }
}
