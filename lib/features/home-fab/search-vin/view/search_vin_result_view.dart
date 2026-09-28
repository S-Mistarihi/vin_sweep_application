import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/features/home-fab/search-vin/controller/search_vin_controller.dart';
import 'package:vin_sweep_application/features/home-fab/search-vin/view/general-info/view/general_info_view.dart';
import 'package:vin_sweep_application/features/home-fab/search-vin/view/reports/view/reports_view.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_scan_vin_number_header.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../enter-vin/model/vehicle_response.dart';

class SearchVinResultView extends StatelessWidget {
  const SearchVinResultView({
    super.key,
    required this.vinNumber,
    required this.vehicleData,
    required this.vehicleName,
    this.vehicleType,
  });

  final String vinNumber;
  final List<VehicleDatum> vehicleData;
  final String vehicleName;
  final String? vehicleType;

  @override
  Widget build(BuildContext context) {
    final SearchVinController controller = Get.put(
      SearchVinController(vinNumber: vinNumber),
    );

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            CustomScanVinNumberHeader(
              headerSpace: 25,
              vinNumber: vinNumber,
              headerMainText: vehicleName,
              headerSubText: vehicleType != null && vehicleType!.isNotEmpty
                  ? vehicleType!
                  : '',
              leftIcon: AppAssets().closeIcon,
            ),
            Positioned(
              top: 22.h,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      _buildAuthSwitcher(context, controller),
                      controller.isInfo
                          ? GeneralInfoView(
                              categories: vehicleData,
                              controller: controller,
                            )
                          : ReportsView(),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 90.h,
              right: 6.w,
              left: 6.w,
              bottom: 5.h,
              child: CustomButton(
                onPressed: () {},
                text: S.of(context).buyReportButton,
                backgroundColor: AppColors().buttonWithBackground,
                foregroundColor: AppColors().buttonWithBackgroundText,
                textSize: 20,
                fontWeight: FontWeight.bold,
                horizontalPadding: 128,
                verticalPadding: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthSwitcher(
    BuildContext context,
    SearchVinController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 9),
      decoration: BoxDecoration(
        color: AppColors().switcherBackgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            alignment: controller.isInfo
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: 43.w,
              height: 4.5.h,
              decoration: BoxDecoration(
                color: AppColors().baseColor,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: controller.switchToInfo,
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).generalInfoSwitcher,
                      style: TextStyle(
                        color: AppColors().accentColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: controller.switchToReport,
                  child: Container(
                    height: 45,
                    alignment: Alignment.center,
                    child: Text(
                      S.of(context).reportsSwitcher,
                      style: TextStyle(
                        color: AppColors().accentColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
