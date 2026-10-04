import 'package:get/get.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/features/reports/repository/report_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

class VehicleReportsController extends GetxController {
  VehicleReportsController({
    required this.vin,
    List<PdfReportDetails> initial = const [],
  }) {
    reports.assignAll(initial);
  }

  final String vin;
  final RxList<PdfReportDetails> reports = <PdfReportDetails>[].obs;

  void addReport(PdfReportDetails report) {
    reports.removeWhere(
      (r) => r.reportId != null && r.reportId == report.reportId,
    );
    reports.insert(0, report);
  }

  Future<void> refreshReports() async {
    final context = Get.context;
    if (context == null) return;

    final result = await createReportRepository().getReportsByVin(
      context: context,
      vin: vin,
    );
    if (result case Success(:final data)) {
      if (data.isNotEmpty) reports.assignAll(data);
    }
  }
}
