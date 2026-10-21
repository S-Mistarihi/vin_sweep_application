import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/custom_home_header.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/widget/home_plan_card.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/widget/home_premium_header.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/widget/scan_search_bar.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/widget/scans_list_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/scan_history/view/scan_history_view.dart';

import '../../../../../generated/l10n.dart';
import '../model/plan_card_info.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());

    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            if (c.planInfo.variant == HomePlanVariant.premium) {
              return const HomePremiumHeader();
            }
            return Column(
              children: [
                CustomHomeHeader(
                  totalSweeps: c.totalSweeps,
                  planCard: const HomePlanCard(),
                ),
                SizedBox(height: 13.h),
              ],
            );
          }),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Obx(
              () => Row(
                children: [
                  Text(
                    S.of(context).latestScans,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors().accentColor,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  if (c.scans.isNotEmpty)
                    GestureDetector(
                      onTap: () => Get.to(() => const ScanHistoryView()),
                      child: Text(
                        S.of(context).seeAll,
                        style: TextStyle(
                          color: AppColors().smallTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Obx(
            () => (c.scans.isNotEmpty || c.query.value.isNotEmpty)
                ? const Padding(
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 4),
                    child: ScanSearchBar(),
                  )
                : const SizedBox.shrink(),
          ),
          Expanded(
            child: ScansListView(
              limit: HomeController.latestCount,
              bottomPadding: 15.h,
            ),
          ),
        ],
      ),
    );
  }
}
