import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../configuration/app_colors.dart';
import '../../../home/controller/home_controller.dart';
import '../../../home/view/widget/scan_search_bar.dart';
import '../../../home/view/widget/scans_list_view.dart';

class ScanHistoryView extends StatefulWidget {
  const ScanHistoryView({super.key});

  @override
  State<ScanHistoryView> createState() => _ScanHistoryViewState();
}

class _ScanHistoryViewState extends State<ScanHistoryView> {
  final HomeController controller = Get.put(HomeController());

  @override
  void dispose() {
    controller.clearSearch(); // commen with home query
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'Scans History',
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
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  ScanSearchBar(),
                  const SizedBox(height: 8),
                  const Expanded(child: ScansListView(bottomPadding: 24)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
