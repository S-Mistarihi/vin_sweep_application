import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/model/plan_card_info.dart';

import 'active_plan_skeleton.dart';

class HomePlanCard extends StatelessWidget {
  const HomePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<HomeController>();

    return GestureDetector(
      onTap: c.openPlans,
      child: Container(
        height: 16.h,
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors().cardPlanShadow,
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Obx(() => _body(c)),
      ),
    );
  }

  Widget _body(HomeController c) {
    //Loading state
    if (c.isLoadingPlan.value && c.subscription.value == null) {
      return const ActivePlanSkeleton();
    }

    //Error state
    if (c.planError.value != null && c.subscription.value == null) {
      return Row(
        children: [
          Expanded(
            child: Text(
              "Couldn't load your plan",
              style: TextStyle(color: AppColors().errorText, fontSize: 14),
            ),
          ),
          TextButton(onPressed: c.loadPlan, child: const Text('Retry')),
        ],
      );
    }

    final info = c.planInfo;
    switch (info.variant) {
      //No Plan state
      case HomePlanVariant.none:
        return _emptyState(
          c,
          title: 'No active plan',
          subtitle: 'Choose a plan to start generating reports',
          button: 'Choose a Plan',
        );
      //Expired State
      case HomePlanVariant.expired:
        return _emptyState(
          c,
          title: info.title,
          subtitle: info.subtitle,
          button: 'Renew Plan',
          expired: true,
        );
      //Active State [starter/ basic/ business/ premium]
      default:
        return _activeState(info);
    }
  }

  /// ───────── rendering card if plan is effective ─────────
  Widget _activeState(PlanCardInfo info) {
    final isStarter = info.variant == HomePlanVariant.starter;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        _header(info),
        const Spacer(),
        //starter plan effective
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
          const SizedBox(height: 8),
          _statRow(
            'Remaining',
            '${info.remaining}/${info.total}',
            valueColor: info.isOutOfReports
                ? AppColors().errorText
                : AppColors().accentColor,
          ),
        ] else ...[
          //Basic/Business plan effective
          Divider(color: AppColors().cardPlanBorder, thickness: 2),
          const SizedBox(height: 8),
          _statRow('Reports Bought', '${info.generated}'),
        ],
      ],
    );
  }

  Widget _header(PlanCardInfo info) {
    final bg = _iconColors(info.variant);
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Transform.scale(
            scale: .5,
            child: SvgPicture.asset(_planIcon(info.variant)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                info.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (info.subtitle != null) ...[
                SizedBox(height: 4),
                Text(
                  info.subtitle!,
                  style: TextStyle(
                    color: AppColors().textFieldLabelColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ),
        _badge('Active', AppColors().activePlanBg, AppColors().activePlanFg),
      ],
    );
  }

  // ───────── none / expired ─────────
  Widget _emptyState(
    HomeController c, {
    required String title,
    String? subtitle,
    required String button,
    bool expired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors().switcherBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.description_outlined,
                color: AppColors().textFieldLabelColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: AppColors().accentColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors().textFieldLabelColor,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            if (expired)
              _badge(
                'Expired',
                AppColors().errorDialogColor,
                AppColors().activePlanFg,
              ),
          ],
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          height: 34,
          child: ElevatedButton(
            onPressed: c.openPlans,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors().buttonWithBackground,
              foregroundColor: AppColors().buttonWithBackgroundText,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(button),
          ),
        ),
      ],
    );
  }

  // ───────── helpers ─────────
  Widget _statRow(String label, String value, {Color? valueColor}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors().accentColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors().accentColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _badge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  //bg color for every file plan
  Color _iconColors(HomePlanVariant v) {
    switch (v) {
      case HomePlanVariant.basic:
        return (AppColors().basicFileBg);
      case HomePlanVariant.business:
        return (AppColors().businessFileBg);
      default: // starter
        return (AppColors().starterFileBg);
    }
  }

  String _planIcon(HomePlanVariant variant) {
    switch (variant) {
      case HomePlanVariant.basic:
        return AppAssets().purpleFileIcon;

      case HomePlanVariant.starter:
        return AppAssets().blueFileIcon;

      case HomePlanVariant.business:
        return AppAssets().greenFileIcon;

      case HomePlanVariant.premium:
        return AppAssets().holdPremiumIcon;

      default:
        return AppAssets().purpleFileIcon;
    }
  }
}
