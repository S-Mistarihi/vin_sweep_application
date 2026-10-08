import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/features/plan-upgrade/review_confirmation/view/widget/payment_method_tile.dart';

import '../../../../../configuration/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../utils/ui/custom_loading_indicator.dart';
import '../../controller/card_selection_mixin.dart';
import 'add_card_tile.dart';

class PaymentMethodsSection extends StatelessWidget {
  const PaymentMethodsSection({super.key, required this.controller, this.plan});

  final CardSelectionMixin controller;
  final PlanModel? plan;

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
          if (controller.isLoadingCards.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: CustomLoadingIndicator(isLoadMore: true),
            );
          }

          return Column(
            children: controller.cards.map((card) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: PaymentMethodTile(
                  card: card,
                  selected: controller.selectedCardId.value == card.id,
                  onTap: () => controller.selectCard(card),
                ),
              );
            }).toList(),
          );
        }),
        const SizedBox(height: 4),
        AddCardTile(onTap: controller.addCard),
      ],
    );
  }
}
