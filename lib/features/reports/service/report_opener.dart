import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

class ReportOpener {
  static final Set<String> _busy = {};

  static Future<void> open(PdfReportDetails report) async {
    final raw = report.downloadUrl?.trim();
    if (raw == null || raw.isEmpty) {
      _error('Report link is not available yet');
      return;
    }

    final Uri uri;
    try {
      var u = Uri.parse(raw);
      if (!u.hasScheme) u = Uri.parse(baseUrl).resolveUri(u);
      uri = u;
    } catch (_) {
      _error('Invalid report link');
      return;
    }

    if (uri.host != Uri.parse(baseUrl).host) {
      await _launchExternal(uri);
      return;
    }

    if (!_busy.add(raw)) return;
    try {
      await _downloadAndOpen(uri, report);
    } finally {
      _busy.remove(raw);
    }
  }

  static Future<void> _downloadAndOpen(Uri uri, PdfReportDetails report) async {
    final result = await HttpWrapper(
      url: uri.toString(),
      context: Get.context,
      showLoading: true,
      headers: {'Accept': '*/*'},
    ).getFile();

    switch (result) {
      case Failure(:final exception):
        _error(exception.message);
      case Success(:final data):
        final bytes = _extractPdfBytes(data.body);
        if (bytes == null) {
          _error('The downloaded file is not a valid PDF');
          return;
        }

        try {
          final file = File(
            '${Directory.systemTemp.path}/${_safeName(report)}',
          );
          await file.writeAsBytes(bytes, flush: true);

          final opened = await OpenFilex.open(
            file.path,
            type: 'application/pdf',
          );
          if (opened.type != ResultType.done) {
            _error('No app found to open PDF files');
          }
        } catch (_) {
          _error('Could not open the report');
        }
    }
  }

  static Future<void> _launchExternal(Uri uri) async {
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok) _error('Could not open the report');
    } catch (_) {
      _error('Could not open the report');
    }
  }

  static bool _isPdf(Uint8List b) =>
      b.length >= 4 &&
      b[0] == 0x25 &&
      b[1] == 0x50 &&
      b[2] == 0x44 &&
      b[3] == 0x46;

  static Uint8List? _extractPdfBytes(Uint8List? body) {
    if (body == null || body.isEmpty) return null;
    if (_isPdf(body)) return body;

    try {
      final decoded = jsonDecode(utf8.decode(body));
      Uint8List? candidate;

      if (decoded is List && decoded.isNotEmpty) {
        if (decoded.every((e) => e is int)) {
          candidate = Uint8List.fromList(decoded.cast<int>());
        } else if (decoded.first is String) {
          candidate = base64Decode(decoded.join());
        }
      } else if (decoded is Map) {
        final v = decoded['result'] ?? decoded['data'];
        if (v is String) candidate = base64Decode(v);
      }

      if (candidate != null && _isPdf(candidate)) return candidate;
    } catch (_) {}
    return null;
  }

  static String _safeName(PdfReportDetails r) {
    var name = (r.fileName?.trim().isNotEmpty ?? false)
        ? r.fileName!.trim()
        : 'report_${r.reportId ?? DateTime.now().millisecondsSinceEpoch}.pdf';
    name = name.replaceAll(RegExp(r'[^\w.\- ]'), '_');
    if (!name.toLowerCase().endsWith('.pdf')) name = '$name.pdf';
    return name;
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
