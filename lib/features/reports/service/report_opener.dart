
import 'dart:io';

import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../generated/l10n.dart';
import '../../../utils/ui/custom_snakbar.dart';
import '../../pdf-report/service/report_file_service.dart';
import '../../pdf-report/view/pdf_report_view.dart';

class ReportOpener {
  static final Set<String> _busy = {};

  static void open(PdfReportDetails report) {
    Get.to(
      () => PdfReportView(report: report),
      transition: Transition.rightToLeft,
    );
  }

  static Future<void> openExternal(PdfReportDetails report) async {
    final key = report.downloadUrl ?? '${report.reportId}';
    if (!_busy.add(key)) return;

    try {
      final result = await ReportFileService.fetchPdf(
        report,
        showLoading: true,
      );

      switch (result) {
        case Failure(:final exception):
          _error(exception.message);
        case Success(:final data):
          final file = File(
            '${Directory.systemTemp.path}/${ReportFileService.safeName(report)}',
          );
          await file.writeAsBytes(data, flush: true);

          final opened = await OpenFilex.open(
            file.path,
            type: 'application/pdf',
          );
          if (opened.type != ResultType.done) {
            _error(S.of(Get.context!).noAppFoundToOpenPdfFiles);
          }
      }
    } catch (_) {
      _error(S.of(Get.context!).couldNotOpenTheReport);
    } finally {
      _busy.remove(key);
    }
  }

  static void _error(String message) {
    CustomSnakbar.error(
      S.of(Get.context!).report,
      message,
      duration: const Duration(seconds: 5),
    );
  }
}
