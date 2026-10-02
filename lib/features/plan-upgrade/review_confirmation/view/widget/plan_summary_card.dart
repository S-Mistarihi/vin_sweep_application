import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';

import '../../../../../generated/l10n.dart';

class PlanSummaryCard extends StatelessWidget {
  const PlanSummaryCard({super.key, required this.plan});

  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors().baseColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors().cardPlanBorder, width: 2),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label(S.of(context).planCardLabel),
                const SizedBox(height: 2),
                _value(plan.headlinePrimary ?? plan.name ?? ''),

                const SizedBox(height: 14),

                _label(S.of(context).reportsCardLabel),
                const SizedBox(height: 2),
                _value(
                  plan.headlineSecondary ?? '${plan.reportsCount ?? 0} Reports',
                ),
              ],
            ),
          ),

          Text(
            plan.priceLabel ?? '\$${plan.price ?? 0}',
            style: TextStyle(
              color: AppColors().accentColor,
              fontSize: 37,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors().cardUpgradeLabelText,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _value(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColors().accentColor,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
