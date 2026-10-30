import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/utils/ui/common/custom_main_header.dart';
import 'package:vin_sweep_application/utils/ui/custom_button.dart';

import '../../../generated/l10n.dart';
import '../controller/pdf_report_controller.dart';

class PdfReportView extends StatefulWidget {
  const PdfReportView({super.key, required this.report});

  final PdfReportDetails report;

  @override
  State<PdfReportView> createState() => _PdfReportViewState();
}

class _PdfReportViewState extends State<PdfReportView> {
  late final String _tag;
  late final PdfReportController controller;

  @override
  void initState() {
    super.initState();
    _tag = 'pdf_${widget.report.reportId ?? widget.report.downloadUrl}';
    controller = Get.put(PdfReportController(widget.report), tag: _tag);
  }

  @override
  void dispose() {
    Get.delete<PdfReportController>(tag: _tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'PDF Report', // TODO: l10n
            leftIcon: AppAssets().backIcon,
            size: 65,
          ),
          Positioned(
            top: 10.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: AppColors().baseColor,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(
                    child: SpinKitSquareCircle(
                      color: AppColors().buttonWithBackground,
                      size: 50.0,
                    ),
                  );
                }

                final data = controller.bytes.value;
                if (data == null) return _buildError(context);

                return Padding(
                  padding: EdgeInsets.only(bottom: 11.h),
                  child: PdfViewer.data(data, sourceName: controller.fileName),
                );
              }),
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 4.h,
            child: Obx(() {
              final ready = controller.bytes.value != null;
              return Opacity(
                opacity: ready ? 1 : 0.5,
                child: CustomButton(
                  onPressed: controller.download,
                  text: controller.isSaving.value ? '...' : 'Download PDF',
                  // TODO: l10n
                  backgroundColor: AppColors().buttonWithBackground,
                  foregroundColor: AppColors().buttonWithBackgroundText,
                  textSize: 20,
                  fontWeight: FontWeight.bold,
                  horizontalPadding: 100,
                  verticalPadding: 12,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            controller.error.value ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors().errorText, fontSize: 18),
          ),
          const SizedBox(height: 16),
          CustomButton(
            onPressed: controller.load,
            text: S.of(context).retryButton,
            backgroundColor: AppColors().buttonWithBackground,
            foregroundColor: AppColors().buttonWithBackgroundText,
            textSize: 20,
            fontWeight: FontWeight.bold,
            horizontalPadding: 140,
            verticalPadding: 12,
          ),
        ],
      ),
    );
  }
}
