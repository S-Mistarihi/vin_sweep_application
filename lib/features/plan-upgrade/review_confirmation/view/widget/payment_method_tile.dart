import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/pay-method/model/payment_method_response.dart';
import '../../controller/review_confirmation_controller.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.method,
    required this.controller,
  });

  final PayMethod method;
  final ReviewConfirmationController controller;

  @override
  Widget build(BuildContext context) {
    final selected =
        controller.selectedMethodId.value == method.paymentMethodId;

    return GestureDetector(
      onTap: () {
        controller.selectMethod(method.paymentMethodId);
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors().switcherBackgroundColor),
        ),
        child: Row(
          children: [
            Icon(Icons.credit_card, size: 22, color: AppColors().accentColor),

            const SizedBox(width: 16),

            Expanded(
              child: Text(
                method.maskedNumber,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors().accentColor : Colors.transparent,
                border: Border.all(
                  color: selected
                      ? AppColors().accentColor
                      : AppColors().switcherBackgroundColor,
                  width: 2,
                ),
              ),
              child: selected
                  ? Icon(Icons.check, size: 14, color: AppColors().baseColor)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
