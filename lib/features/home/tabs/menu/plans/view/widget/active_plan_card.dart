import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/plan_card_info.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/plans_navigator.dart';

class ActivePlanCard extends StatelessWidget {
  const ActivePlanCard({super.key});

  // TODO: انقليهم لـ AppColors
  static const Color _gradientStart = Color(0xff6A6FD6);
  static const Color _gradientEnd = Color(0xff3C4BA0);
  static const Color _orange = Color(0xffF5A300);

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_gradientStart, _gradientEnd],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Obx(() {
        if (c.isLoadingPlan.value && c.subscription.value == null) {
          return const SizedBox(
            height: 110,
            child: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          );
        }
        if (c.planError.value != null && c.subscription.value == null) {
          return Row(
            children: [
              const Expanded(
                child: Text(
                  "Couldn't load your plan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: c.loadPlan,
                child: const Text(
                  'Retry',
                  style: TextStyle(color: Colors.white),
                ),
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
                    ? 'No active plan'
                    : info.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (info.variant != HomePlanVariant.none)
              _badge(
                info.variant == HomePlanVariant.expired ? 'Expired' : 'Active',
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
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(_orange),
            ),
          ),
          const SizedBox(height: 10),
          _statRow('Remaining', '${info.remaining}/${info.total}'),
        ] else if (!inactive) ...[
          _statRow('Reports Bought', '${info.generated}'),
        ],
        if (showUpgrade) ...[
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: PlansNavigator.openAllPlans,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                info.variant == HomePlanVariant.none
                    ? 'Choose a Plan'
                    : info.variant == HomePlanVariant.expired
                    ? 'Renew Plan'
                    : 'Upgrade',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _statRow(String label, String value) {
    const style = TextStyle(
      color: Colors.white,
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
        color: expired
            ? AppColors().errorDialogColor
            : AppColors().successDialogColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: expired ? Colors.white : AppColors().defualtTextColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}