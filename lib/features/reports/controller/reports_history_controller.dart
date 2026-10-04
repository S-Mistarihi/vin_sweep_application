import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vin_sweep_application/features/home/tabs/home/controller/home_controller.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/features/reports/repository/report_repository.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

class ReportGroup {
  final String label;
  final List<PdfReportDetails> items;

  ReportGroup(this.label, this.items);
}

class ReportsHistoryController extends GetxController {
  final ReportRepository _repo = createReportRepository();

  final RxList<PdfReportDetails> reports = <PdfReportDetails>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString error = RxnString();
  final RxString query = ''.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    error.value = null;

    final result = await _repo.getMyReports(context: Get.context!);
    switch (result) {
      case Failure(:final exception):
        error.value = exception.message;
      case Success(:final data):
        reports.assignAll(data);
    }

    isLoading.value = false;
  }

  Future<void> refreshAll() async {
    await Future.wait([
      load(),
      if (Get.isRegistered<HomeController>())
        Get.find<HomeController>().loadScans(),
    ]);
  }

  List<ReportGroup> groups(Map<String, String> names, {int? limit}) {
    final q = query.value.trim().toLowerCase();

    var list = [...reports]
      ..sort(
        (a, b) => (b.generatedAt ?? DateTime(0)).compareTo(
          a.generatedAt ?? DateTime(0),
        ),
      );

    if (q.isNotEmpty) {
      list = list.where((r) {
        final vin = r.vin ?? '';
        return (names[vin] ?? '').toLowerCase().contains(q) ||
            vin.toLowerCase().contains(q) ||
            (r.fileName ?? '').toLowerCase().contains(q);
      }).toList();
    } else if (limit != null) {
      list = list.take(limit).toList();
    }

    final fmt = DateFormat('dd MMM, yyyy');
    final map = <String, List<PdfReportDetails>>{};
    for (final r in list) {
      final label = r.generatedAt == null
          ? 'Unknown date'
          : fmt.format(r.generatedAt!.toLocal());
      map.putIfAbsent(label, () => []).add(r);
    }
    return map.entries.map((e) => ReportGroup(e.key, e.value)).toList();
  }
}
