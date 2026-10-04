import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/plans_navigator.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/view/widget/active_plan_card.dart';
import 'package:vin_sweep_application/features/reports/controller/reports_history_controller.dart';
import 'package:vin_sweep_application/features/reports/view/reports_history_view.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';
import 'package:vin_sweep_application/utils/ui/common/search_filter_bar.dart';

import '../../../../../reports/view/widget/report_history_list.dart';

class MyPlansView extends StatefulWidget {
  const MyPlansView({super.key});

  @override
  State<MyPlansView> createState() => _MyPlansViewState();
}

class _MyPlansViewState extends State<MyPlansView> {
  static const int _historyLimit = 5;

  late final ReportsHistoryController history;

  @override
  void initState() {
    super.initState();
    history = Get.put(ReportsHistoryController());

    if (Get.isRegistered<HomeController>()) {
      Get.find<HomeController>().loadPlan();
    }
  }

  @override
  void dispose() {
    Get.delete<ReportsHistoryController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: S.of(context).myPlansTitle,
            leftIcon: AppAssets().backIcon,
            size: 110,
          ),
          Positioned(
            top: 5.5.h,
            right: 20,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: PlansNavigator.openAllPlans,
              child: Text(
                'View all Plans',
                style: TextStyle(color: AppColors().baseColor, fontSize: 14),
              ),
            ),
          ),
          Positioned(
            top: 13.h,
            right: 0,
            left: 0,
            bottom: 0,
            child: Container(
              width: 100.w,
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: ActivePlanCard(),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Obx(
                          () => Row(
                        children: [
                          Text(
                            'History',
                            style: TextStyle(
                              color: AppColors().accentColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          if (history.reports.isNotEmpty)
                            GestureDetector(
                              onTap: () =>
                                  Get.to(() => const ReportsHistoryView()),
                              child: Text(
                                'See All',
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
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SearchFilterBar(query: history.query),
                  ),
                  const SizedBox(height: 8),
                  const Expanded(
                    child: ReportHistoryList(
                      limit: _historyLimit,
                      bottomPadding: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}