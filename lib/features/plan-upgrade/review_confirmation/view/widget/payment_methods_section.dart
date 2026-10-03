import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/plan-upgrade/review_confirmation/view/widget/payment_method_tile.dart';

import '../../../../../configuration/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../controller/review_confirmation_controller.dart';
import 'add_card_tile.dart';

class PaymentMethodsSection extends StatefulWidget {
  const PaymentMethodsSection({
    super.key,
    required this.controller,
    required this.plan,
  });

  final ReviewConfirmationController controller;
  final PlanModel plan;

  @override
  State<PaymentMethodsSection> createState() => _PaymentMethodsSectionState();
}

class _PaymentMethodsSectionState extends State<PaymentMethodsSection> {
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
          if (widget.controller.isLoadingCards.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: SpinKitSquareCircle(
                  color: AppColors().buttonWithBackground,
                  size: 50.0,
                ),
              ),
            );
          }

          // if (widget.controller.errorMessage.value != null) {
          //   return Padding(
          //     padding: const EdgeInsets.only(bottom: 12),
          //     child: Column(
          //       children: [
          //         Text(
          //           widget.controller.errorMessage.value!,
          //           textAlign: TextAlign.center,
          //           style: TextStyle(
          //             color: AppColors().errorDialogColor,
          //             fontSize: 20,
          //           ),
          //         ),
          //
          //         CustomButton(
          //           onPressed: () => widget.controller.loadMethods(),
          //           text: S.of(context).retryButton,
          //           backgroundColor: AppColors().buttonWithBackground,
          //           foregroundColor: AppColors().buttonWithBackgroundText,
          //           textSize: 20,
          //           fontWeight: FontWeight.bold,
          //           horizontalPadding: 140,
          //           verticalPadding: 12,
          //         ),
          //       ],
          //     ),
          //   );
          // }

          return Column(
            children: widget.controller.cards.map((card) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PaymentMethodTile(
                  card: card,
                  selected: widget.controller.selectedCardId.value == card.id,
                  onTap: () => widget.controller.selectCard(card),
                ),
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 4),
        AddCardTile(
          onTap: widget.controller.addCard,
          // onTap: () async {
          //   final result = await Get.to<SavedCardModel>(
          //         () => const AddCardView(mode: AddCardMode.subscribe),
          //   );
          //
          //   if (result != null) {
          //     widget.controller.cards.insert(0, result);
          //     widget.controller.selectedCardId.value = result.id;
          //   }
          //   // final result = await Get.to<UserPlanResponse>(
          //   //   () => AddCardView(mode: AddCardMode.subscribe),
          //   // );
          //   // if (result != null) Get.back(result: result);
          // },
        ),
      ],
    );
  }
}
