import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';

class ReportOpener {
  static Future<void> open(PdfReportDetails report) async {
    final raw = report.downloadUrl;
    if (raw == null || raw.trim().isEmpty) {
      _error('Report link is not available yet');
      return;
    }

    try {
      var uri = Uri.parse(raw.trim());
      if (!uri.hasScheme) uri = Uri.parse(baseUrl).resolveUri(uri);

      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!opened) _error('Could not open the report');
    } catch (_) {
      _error('Could not open the report');
    }
  }

  static void _error(String message) {
    Get.snackbar(
      'Report',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors().errorDialogColor,
      colorText: AppColors().baseColor,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 5),
    );
  }
}
