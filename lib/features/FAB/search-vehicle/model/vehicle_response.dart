import 'dart:convert';

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
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: VehicleResult.fromJson(json["result"]),
      );
}

class VehicleResult {
  final List<VehicleDatum> vehicleData;
  final List<dynamic> pdfReports;
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
    vehicleData: List<VehicleDatum>.from(
      json["vehicleData"].map((x) => VehicleDatum.fromJson(x)),
    ),
    pdfReports: List<dynamic>.from(json["pdfReports"].map((x) => x)),
    vin: json["vin"],
    message: json["message"],
  );
}

class VehicleDatum {
  final String category;
  final List<CategoryValue> values;

  VehicleDatum({required this.category, required this.values});

  factory VehicleDatum.fromRawJson(String str) =>
      VehicleDatum.fromJson(json.decode(str));

  factory VehicleDatum.fromJson(Map<String, dynamic> json) => VehicleDatum(
    category: json["category"],
    values: List<CategoryValue>.from(
      json["values"].map((x) => CategoryValue.fromJson(x)),
    ),
  );
}

class CategoryValue {
  final String key;
  final String? value;

  CategoryValue({required this.key, required this.value});

  factory CategoryValue.fromRawJson(String str) =>
      CategoryValue.fromJson(json.decode(str));

  factory CategoryValue.fromJson(Map<String, dynamic> json) =>
      CategoryValue(key: json["key"], value: json["value"]);
}
