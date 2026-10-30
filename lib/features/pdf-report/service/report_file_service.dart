import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/features/reports/model/pdf_report_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../generated/l10n.dart';

class ReportFileService {
  ReportFileService._();

  static Future<RepositoryResult<Uint8List>> fetchPdf(
      PdfReportDetails report, {
        bool showLoading = false,
      }) async {
    final s = S.of(Get.context!);

    final raw = report.downloadUrl?.trim();
    if (raw == null || raw.isEmpty) {
      return Failure(MappingException(s.reportLinkIsNotAvailableYet));
    }

    final Uri uri;
    try {
      var u = Uri.parse(raw);
      // رابط نسبي: بنركّبه على الـ baseUrl
      if (!u.hasScheme) u = Uri.parse(baseUrl).resolveUri(u);
      uri = u;
    } catch (_) {
      return Failure(MappingException(s.invalidReportLink));
    }

    Uint8List? body;
    if (uri.host == Uri.parse(baseUrl).host) {
      final result = await HttpWrapper(
        url: uri.toString(),
        context: Get.context,
        showLoading: showLoading,
        headers: {'Accept': '*/*'},
      ).getFile();

      switch (result) {
        case Failure(:final exception):
          return Failure(exception);
        case Success(:final data):
          body = data.body;
      }
    } else {
      try {
        final res = await http.get(uri);
        if (res.statusCode != 200) {
          return Failure(MappingException(s.couldNotOpenTheReport));
        }
        body = res.bodyBytes;
      } catch (_) {
        return Failure(MappingException(s.couldNotOpenTheReport));
      }
    }

    final pdf = _extractPdfBytes(body);
    if (pdf == null) {
      return Failure(MappingException(s.theDownloadedFileIsNotAValidPdf));
    }
    return Success(pdf);
  }

  /// اسم ملف آمن للحفظ
  static String safeName(PdfReportDetails r) {
    var name = (r.fileName?.trim().isNotEmpty ?? false)
        ? r.fileName!.trim()
        : 'report_${r.reportId ?? DateTime.now().millisecondsSinceEpoch}.pdf';
    name = name.replaceAll(RegExp(r'[^\w.\- ]'), '_');
    if (!name.toLowerCase().endsWith('.pdf')) name = '$name.pdf';
    return name;
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
}