import 'package:vin_sweep_application/features/reports/service/report_opener.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/features/FAB-menu/search-vehicle/view/switcher/general-info/view/general_info_view.dart';
import 'package:vin_sweep_application/features/FAB-menu/search-vehicle/view/switcher/reports/view/report_view.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/ui/common/custom_scan_vin_number_header.dart';
import '../../../../utils/ui/custom_button.dart';
import '../../../../utils/ui/custom_tab_switcher.dart';
import '../../../reports/model/pdf_report_response.dart';
import '../../../reports/view/buy_report_view.dart';
import '../controller/searching_mode_controller.dart';
import '../controller/vehicle_reports_controller.dart';
import '../model/vehicle_response.dart';

class SearchingResult extends StatefulWidget {
  const SearchingResult({
    super.key,
    required this.vinNumber,
    required this.vehicleData,
    required this.vehicleName,
    this.vehicleType,
    required this.pdfReports,
  });

  final String vinNumber;
  final List<VehicleDatum> vehicleData;
  final List<PdfReportDetails> pdfReports;
  final String vehicleName;
  final String? vehicleType;

  @override
  State<SearchingResult> createState() => _SearchingResultState();
}

class _SearchingResultState extends State<SearchingResult> {
  late final SearchingModeController modeController;
  late final VehicleReportsController reportsController;

  @override
  void initState() {
    super.initState();
    modeController = Get.put(SearchingModeController());
    reportsController = Get.put(
      VehicleReportsController(
        vin: widget.vinNumber,
        initial: widget.pdfReports,
      ),
      tag: widget.vinNumber,
    );
  }

  @override
  void dispose() {
    Get.delete<VehicleReportsController>(tag: widget.vinNumber);
    super.dispose();
  }

  /// زر "Get Vehicle History Report":
  ///  - في تقرير جاهز لهاد الـ VIN: بنفتحه مباشرة بدون دفع
  ///  - ما في: شاشة الشراء (لحظة الدفع = زر Confirm). عند النجاح بنفتح
  ///    شاشة PDF Report بالتقرير الجديد، وزر Download PDF هناك بيحفظ الملف بس.
  Future<void> _onGetReport() async {
    final existing = reportsController.latestReport;
    if (existing != null) {
      modeController.switchToReport();
      ReportOpener.open(existing);
      return;
    }

    final report = await Get.to<PdfReportDetails>(
      () =>
          BuyReportView(vin: widget.vinNumber, vehicleName: widget.vehicleName),
    );
    if (report == null) return;

    reportsController.addReport(report);
    modeController.switchToReport(); // الرجوع من شاشة PDF بيوصل لتاب Reports
    reportsController.refreshReports();
    ReportOpener.open(report);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            CustomScanVinNumberHeader(
              headerSpace: 25,
              vinNumber: widget.vinNumber,
              headerMainText: widget.vehicleName,
              headerSubText: widget.vehicleType ?? '',
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
                  ),
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      CustomTabSwitcher(
                        isLeftSelected: modeController.isInfo,
                        leftLabel: S.of(context).generalInfoSwitcher,
                        rightLabel: S.of(context).reportsSwitcher,
                        onLeftTap: modeController.switchToInfo,
                        onRightTap: modeController.switchToReport,
                      ),
                      modeController.isInfo
                          ? GeneralInfoView(vehicleData: widget.vehicleData)
                          : ReportView(controller: reportsController),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors().baseColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors().cardPlanShadow,
              blurRadius: 12,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 45, 16, 32),
            child: SizedBox(
              width: 100.w,
              child: CustomButton(
                onPressed: _onGetReport,
                text: 'Get Vehicle History Report',
                // TODO: l10n
                backgroundColor: AppColors().buttonWithBackground,
                foregroundColor: AppColors().buttonWithBackgroundText,
                textSize: 20,
                fontWeight: FontWeight.bold,
                horizontalPadding: 0,
                verticalPadding: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
