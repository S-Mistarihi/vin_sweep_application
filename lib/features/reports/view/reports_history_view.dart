import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/reports/controller/reports_history_controller.dart';
import 'package:vin_sweep_application/features/reports/view/widget/report_history_list.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';
import 'package:vin_sweep_application/utils/ui/common/search_filter_bar.dart';

class ReportsHistoryView extends StatefulWidget {
  const ReportsHistoryView({super.key});

  @override
  State<ReportsHistoryView> createState() => _ReportsHistoryViewState();
}

class _ReportsHistoryViewState extends State<ReportsHistoryView> {
  final ReportsHistoryController controller = Get.put(
    ReportsHistoryController(),
  );

  @override
  void dispose() {
    controller.query.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'Reports History',
            leftIcon: AppAssets().backIcon,
            size: 110,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SearchFilterBar(query: controller.query),
                  ),
                  const SizedBox(height: 8),
                  const Expanded(child: ReportHistoryList(bottomPadding: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
