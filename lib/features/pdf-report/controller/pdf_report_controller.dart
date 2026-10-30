import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';

import '../../../generated/l10n.dart';
import '../../../utils/ui/custom_snakbar.dart';
import '../service/report_file_service.dart';

class PdfReportController extends GetxController {
  PdfReportController(this.report);

  final PdfReportDetails report;

  final Rxn<Uint8List> bytes = Rxn<Uint8List>();
  final RxBool isLoading = false.obs;
  final RxBool isSaving = false.obs;
  final RxnString error = RxnString();

  String get fileName => ReportFileService.safeName(report);

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    isLoading.value = true;
    error.value = null;

    final result = await ReportFileService.fetchPdf(report);
    switch (result) {
      case Failure(:final exception):
        error.value = exception.message;
      case Success(:final data):
        bytes.value = data;
    }

    isLoading.value = false;
  }

  Future<void> download() async {
    final data = bytes.value;
    if (data == null || isSaving.value) return;

    isSaving.value = true;
    try {
      final path = await FlutterFileDialog.saveFile(
        params: SaveFileDialogParams(data: data, fileName: fileName),
      );
      if (path != null) {
        CustomSnakbar.success(
          S.of(Get.context!).report,
          'Report saved', // TODO: l10n
        );
      }
    } on PlatformException {
      CustomSnakbar.error(
        S.of(Get.context!).report,
        S.of(Get.context!).couldNotOpenTheReport,
      );
    } finally {
      isSaving.value = false;
    }
  }
}
