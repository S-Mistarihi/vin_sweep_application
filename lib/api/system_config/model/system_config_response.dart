import 'dart:convert';

class SystemConfigResponse {
  final bool success;
  final int code;
  final String message;
  final List<SystemConfigModel>? result;

  SystemConfigResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.result,
  });

  factory SystemConfigResponse.fromRawJson(String str) =>
      SystemConfigResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SystemConfigResponse.fromJson(Map<String, dynamic> json) =>
      SystemConfigResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        result: List<SystemConfigModel>.from(
          json["result"].map((x) => SystemConfigModel.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "message": message,
    "result": result == null
        ? null
        : List<dynamic>.from(result!.map((x) => x.toJson())),
  };
}

class SystemConfigModel {
  final String key;
  final String value;

  SystemConfigModel({required this.key, required this.value});

  factory SystemConfigModel.fromRawJson(String str) =>
      SystemConfigModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SystemConfigModel.fromJson(Map<String, dynamic> json) =>
      SystemConfigModel(key: json["key"], value: json["value"]);

  Map<String, dynamic> toJson() => {"key": key, "value": value};
}
