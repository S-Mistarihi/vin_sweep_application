import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/plan-upgrade/review_confirmation/view/widget/payment_method_tile.dart';

import '../../../../../configuration/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/ui/custom_button.dart';
import '../../controller/review_confirmation_controller.dart';
import 'add_card_tile.dart';

class PaymentMethodsSection extends StatefulWidget {
  const PaymentMethodsSection({super.key, required this.controller});

  final ReviewConfirmationController controller;

  @override
  State<PaymentMethodsSection> createState() => _PaymentMethodsSectionState();
}

class _PaymentMethodsSectionState extends State<PaymentMethodsSection>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).paymentMethod,
          style: TextStyle(
            color: AppColors().accentColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Obx(() {
          if (widget.controller.isLoading.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
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

          if (widget.controller.errorMessage.value != null) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                children: [
                  Text(
                    widget.controller.errorMessage.value!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors().errorDialogColor,
                      fontSize: 20,
                    ),
                  ),

                  CustomButton(
                    onPressed: () => widget.controller.loadMethods(),
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

          return Column(
            children: widget.controller.methods.map((method) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PaymentMethodTile(
                  method: method,
                  controller: widget.controller,
                ),
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 4),
        const AddCardTile(),
      ],
    );
  }
}
