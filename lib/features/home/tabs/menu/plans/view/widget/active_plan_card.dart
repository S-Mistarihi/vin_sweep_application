import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/plan_card_info.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/plans_navigator.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../../../../../generated/l10n.dart';

class ActivePlanCard extends StatelessWidget {
  const ActivePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors().firstColorActivePlan,
            AppColors().secondColorActivePlan,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Obx(() {
        if (c.isLoadingPlan.value && c.subscription.value == null) {
          return SizedBox(
            height: 110,
            child: Center(
              child: CircularProgressIndicator(
                color: AppColors().buttonWithBackground,
              ),
            ),
          );
        }
        if (c.planError.value != null && c.subscription.value == null) {
          return Row(
            children: [
              Expanded(
                child: Text(
                  S.of(context).couldntLoadYourPlan,
                  style: TextStyle(
                    color: AppColors().textFieldLabelColor,
                    fontSize: 18,
                  ),
                ),
              ),
              CustomButton(
                onPressed: c.loadPlan,
                text: S.of(context).retryButton,
                backgroundColor: AppColors().buttonWithBackground,
                foregroundColor: AppColors().buttonWithBackgroundText,
                textSize: 20,
                fontWeight: FontWeight.bold,
                horizontalPadding: 95,
                verticalPadding: 12,
              ),
            ],
          );
        }
        return _content(c.planInfo);
      }),
    );
  }

  Widget _content(PlanCardInfo info) {
    final inactive =
        info.variant == HomePlanVariant.none ||
        info.variant == HomePlanVariant.expired;
    final isStarter = info.variant == HomePlanVariant.starter;
    final showUpgrade =
        inactive ||
        info.variant == HomePlanVariant.starter ||
        info.variant == HomePlanVariant.basic;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                info.variant == HomePlanVariant.none
                    ? S.of(Get.context!).noActivePlan
                    : info.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors().baseColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (info.variant != HomePlanVariant.none)
              _badge(
                info.variant == HomePlanVariant.expired
                    ? S.of(Get.context!).expired
                    : S.of(Get.context!).active,
                expired: info.variant == HomePlanVariant.expired,
              ),
          ],
        ),
        if (info.subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            info.subtitle!,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ],
        const SizedBox(height: 16),
        if (isStarter) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: info.progress,
              minHeight: 8,
              backgroundColor: AppColors().remainingSlider,
              valueColor: AlwaysStoppedAnimation(AppColors().orangeSlider),
            ),
          ),
          const SizedBox(height: 10),
          _statRow(
            S.of(Get.context!).remaining,
            '${info.remaining}/${info.total}',
          ),
        ] else if (!inactive) ...[
          _statRow(S.of(Get.context!).reportsBought, '${info.generated}'),
        ],
        if (showUpgrade) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: 100.w,
            height: 44,
            child: OutlinedButton(
              onPressed: PlansNavigator.openAllPlans,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors().baseColor,
                side: BorderSide(color: AppColors().baseColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                info.variant == HomePlanVariant.none
                    ? S.of(Get.context!).chooseAPlan
                    : info.variant == HomePlanVariant.expired
                    ? S.of(Get.context!).renewPlan
                    : S.of(Get.context!).upgrade,
                style: TextStyle(fontSize: 16, color: AppColors().baseColor),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _statRow(String label, String value) {
    var style = TextStyle(
      color: AppColors().baseColor,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    return Row(
      children: [
        Text(label, style: style),
        const Spacer(),
        Text(value, style: style),
      ],
    );
  }

  Widget _badge(String text, {bool expired = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: expired ? AppColors().errorText : AppColors().activePlanBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: expired ? AppColors().baseColor : AppColors().activePlanFg,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
