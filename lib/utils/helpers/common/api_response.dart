import 'dart:typed_data';

class ApiResponse {
  Uint8List? body;
  String? stringBody;
  Map<String, String>? headers;
  int statusCode;

  ApiResponse({
    this.body,
    this.stringBody,
    this.headers,
    this.statusCode = 400,
  });

  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  ApiResponse.clone(ApiResponse response)
    : this(
        body: response.body,
        stringBody: response.stringBody,
        headers: response.headers,
        statusCode: response.statusCode,
      );
}
