class GenericResponse {
  final bool success;
  final int code;
  final String message;

  GenericResponse({
    required this.success,
    required this.code,
    required this.message,
  });

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      GenericResponse(
        success: json['success'] ?? false,
        code: json['code'] ?? 0,
        message: json['message']?.toString() ?? '',
      );
}
