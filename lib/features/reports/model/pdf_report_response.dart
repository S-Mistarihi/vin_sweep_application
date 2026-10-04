import 'dart:convert';

import 'package:intl/intl.dart';

class PdfReportResponse {
  final bool success;
  final int code;
  final String message;
  final PdfReportDetails result;

  PdfReportResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory PdfReportResponse.fromRawJson(String str) =>
      PdfReportResponse.fromJson(json.decode(str));

  factory PdfReportResponse.fromJson(Map<String, dynamic> json) =>
      PdfReportResponse(
        success: json["success"] ?? '',
        code: json["code"] ?? 0,
        message: json["message"] ?? '',
        result: PdfReportDetails.fromJson(json["result"]),
      );
}

class PdfReportDetails {
  final int? reportId;
  final String? vin;
  final String? fileName;
  final String? downloadUrl;
  final int? fileSize;
  final DateTime? generatedAt;
  final int? downloadCount;
  final DateTime? lastDownloadedAt;
  final String? message;

  const PdfReportDetails({
    this.reportId,
    this.vin,
    this.fileName,
    this.downloadUrl,
    this.fileSize,
    this.generatedAt,
    this.downloadCount,
    this.lastDownloadedAt,
    this.message,
  });

  factory PdfReportDetails.fromJson(Map<String, dynamic> json) =>
      PdfReportDetails(
        reportId: (json['reportId'] as num?)?.toInt(),
        vin: json['vin'] as String?,
        fileName: json['fileName'] as String?,
        downloadUrl: json['downloadUrl'] as String?,
        fileSize: (json['fileSize'] as num?)?.toInt(),
        generatedAt: _date(json['generatedAt']),
        downloadCount: (json['downloadCount'] as num?)?.toInt(),
        lastDownloadedAt: _date(json['lastDownloadedAt']),
        message: json['message'] as String?,
      );

  static DateTime? _date(dynamic v) =>
      v == null ? null : DateTime.tryParse(v.toString());
}

extension PdfReportX on PdfReportDetails {
  /// 20 Jun 2025
  String get formattedDate => generatedAt == null
      ? ''
      : DateFormat('dd MMM yyyy').format(generatedAt!.toLocal());

  /// 240 KB / 1.2 MB
  String get formattedSize {
    final b = fileSize;
    if (b == null || b <= 0) return '';
    if (b < 1024) return '$b B';
    if (b < 1024 * 1024) return '${(b / 1024).round()} KB';
    return '${(b / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
