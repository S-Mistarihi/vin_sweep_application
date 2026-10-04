import 'dart:convert';

import '../../../reports/model/pdf_report_response.dart';

class VehicleResponse {
  final bool success;
  final int code;
  final String message;
  final VehicleResult result;

  VehicleResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory VehicleResponse.fromRawJson(String str) =>
      VehicleResponse.fromJson(json.decode(str));

  factory VehicleResponse.fromJson(Map<String, dynamic> json) =>
      VehicleResponse(
        success: json["success"] ?? false,
        code: json["code"] ?? 0,
        message: json["message"] ?? 0,
        result: VehicleResult.fromJson(
          (json["result"] as Map<String, dynamic>?) ?? {},
        ),
      );
}

class VehicleResult {
  final List<VehicleDatum> vehicleData;
  final List<PdfReportDetails> pdfReports;
  final String vin;
  final String message;

  VehicleResult({
    required this.vehicleData,
    required this.pdfReports,
    required this.vin,
    required this.message,
  });

  factory VehicleResult.fromRawJson(String str) =>
      VehicleResult.fromJson(json.decode(str));

  factory VehicleResult.fromJson(Map<String, dynamic> json) => VehicleResult(
    vehicleData: (json["vehicleData"] as List? ?? [])
        .map((x) => VehicleDatum.fromJson(x as Map<String, dynamic>))
        .toList(),
    pdfReports: (json["pdfReports"] as List? ?? [])
        .map((x) => PdfReportDetails.fromJson(x as Map<String, dynamic>))
        .toList(),
    vin: json["vin"] ?? '',
    message: json["message"] ?? '',
  );
}

class VehicleDatum {
  final String category;
  final List<CategoryValue> values;

  VehicleDatum({required this.category, required this.values});

  factory VehicleDatum.fromRawJson(String str) =>
      VehicleDatum.fromJson(json.decode(str));

  factory VehicleDatum.fromJson(Map<String, dynamic> json) => VehicleDatum(
    category: json["category"] ?? '',
    values: (json["values"] as List? ?? [])
        .map((x) => CategoryValue.fromJson(x as Map<String, dynamic>))
        .toList(),
  );
}

class CategoryValue {
  final String key;
  final String? value;

  CategoryValue({required this.key, required this.value});

  factory CategoryValue.fromRawJson(String str) =>
      CategoryValue.fromJson(json.decode(str));

  factory CategoryValue.fromJson(Map<String, dynamic> json) =>
      CategoryValue(key: json["key"] ?? '', value: json["value"] ?? '');
}
