import 'dart:async' as async;
import 'dart:convert';
import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:vin_sweep_application/configuration/current_session.dart';

import '../../../generated/l10n.dart';
import '../../../l10n/app_locale.dart';
import '../../ui/progress_hud.dart';
import '../common/api_response.dart';
import '../common/exception/repository_exception.dart';
import '../common/repository_result.dart';

enum HttpMethod { get, post, put, delete }

class HttpWrapper {
  final String url;
  final BuildContext? context;
  final dynamic postParameters; //Contains [post-body]
  final Map<String, String>? files;
  final Map<String, List<String>>? filesList;
  final Map<String, String>? headers;
  final bool showLoading;
  final bool unFocusPrimary;
  final Duration timeout;

  late final Map<String, String> _headers;

  HttpWrapper({
    required this.url,
    this.context,
    this.postParameters,
    this.files,
    this.filesList,
    this.headers,
    this.showLoading = false,
    this.unFocusPrimary = true,
    this.timeout = const Duration(seconds: 60),
  }) {
    if (unFocusPrimary) {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    _headers = Map<String, String>.from(
      headers ??
          {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Accept-Language': AppLocale().isArabic() ? '1' : '2', // backend
          },
    );

    if (CurrentSession().getUser() != null &&
        CurrentSession().getUser()?.accessToken != null) {
      _headers['Authorization'] =
          '${CurrentSession().getUser()!.tokenType} ${CurrentSession().getUser()!.accessToken}';
    }
  }

  Future<RepositoryResult<ApiResponse>> get() => _send(HttpMethod.get);

  Future<RepositoryResult<ApiResponse>> post() => _send(HttpMethod.post);

  Future<RepositoryResult<ApiResponse>> put() => _send(HttpMethod.put);

  Future<RepositoryResult<ApiResponse>> delete() => _send(HttpMethod.delete);

  Future<RepositoryResult<ApiResponse>> getFile() async {
    _startLoadingIfNeeded();
    try {
      final validationError = _validateUrl();
      if (validationError != null) return validationError;

      final client = _createIoClient();
      try {
        final response = await client
            .get(Uri.parse(url), headers: _headers)
            .timeout(timeout);
        return _mapHttpResponse(response);
      } finally {
        client.close();
      }
    } on io.SocketException catch (error, stackTrace) {
      return _networkFailure(error, stackTrace);
    } on async.TimeoutException catch (error, stackTrace) {
      return _timeoutFailure(error, stackTrace);
    } on io.HttpException catch (error, stackTrace) {
      return _httpTransportFailure(error, stackTrace);
    } on FormatException catch (error, stackTrace) {
      return _formatFailure(error, stackTrace);
    } catch (error, stackTrace) {
      return _unknownFailure(error, stackTrace);
    } finally {
      _stopLoadingIfNeeded();
    }
  }

  Future<RepositoryResult<ApiResponse>> multiPartPost() {
    return _sendMultipart(files: files);
  }

  Future<RepositoryResult<ApiResponse>> multiPartListPost() {
    return _sendMultipart(filesList: filesList);
  }

  Future<RepositoryResult<ApiResponse>> _send(HttpMethod method) async {
    _startLoadingIfNeeded();
    try {
      final validationError = _validateUrl();
      if (validationError != null) return validationError;

      final client = _createIoClient();
      try {
        final uri = Uri.parse(url);
        final body = _encodeBody(method);

        late final http.Response response;
        switch (method) {
          case HttpMethod.get:
            response = await client
                .get(uri, headers: _headers)
                .timeout(timeout);
          case HttpMethod.post:
            response = await client
                .post(uri, headers: _headers, body: body, encoding: utf8)
                .timeout(timeout);
          case HttpMethod.put:
            response = await client
                .put(uri, headers: _headers, body: body, encoding: utf8)
                .timeout(timeout);
          case HttpMethod.delete:
            response = await client
                .delete(uri, headers: _headers, body: body, encoding: utf8)
                .timeout(timeout);
        }

        _debugPrintWithResponse(method.name.toUpperCase(), response);
        return _mapHttpResponse(response);
      } finally {
        client.close();
      }
    } on io.SocketException catch (error, stackTrace) {
      _debugPrint('SocketException');
      return _networkFailure(error, stackTrace);
    } on async.TimeoutException catch (error, stackTrace) {
      _debugPrint('Timeout');
      return _timeoutFailure(error, stackTrace);
    } on io.HttpException catch (error, stackTrace) {
      _debugPrint('HttpException');
      return _httpTransportFailure(error, stackTrace);
    } on FormatException catch (error, stackTrace) {
      _debugPrint('FormatException');
      return _formatFailure(error, stackTrace);
    } catch (error, stackTrace) {
      _debugPrint('Unexpected error: $error');
      return _unknownFailure(error, stackTrace);
    } finally {
      _stopLoadingIfNeeded();
    }
  }

  Future<RepositoryResult<ApiResponse>> _sendMultipart({
    Map<String, String>? files,
    Map<String, List<String>>? filesList,
  }) async {
    _startLoadingIfNeeded();
    try {
      final validationError = _validateUrl();
      if (validationError != null) return validationError;

      final request = http.MultipartRequest('POST', Uri.parse(url));

      final multipartHeaders = Map<String, String>.from(_headers)
        ..remove('Content-Type');
      request.headers.addAll(multipartHeaders);

      if (postParameters is Map<String, String>) {
        request.fields.addAll(postParameters as Map<String, String>);
      } else if (postParameters is Map) {
        postParameters.forEach((key, value) {
          request.fields[key.toString()] = value?.toString() ?? '';
        });
      }

      if (files != null) {
        for (final entry in files.entries) {
          request.files.add(
            await http.MultipartFile.fromPath(entry.key, entry.value),
          );
        }
      }

      if (filesList != null) {
        for (final entry in filesList.entries) {
          for (final path in entry.value) {
            request.files.add(
              await http.MultipartFile.fromPath(entry.key, path),
            );
          }
        }
      }

      final streamed = await request.send().timeout(timeout);
      final response = await http.Response.fromStream(streamed);
      _debugPrintWithResponse('MULTIPART POST', response);
      return _mapHttpResponse(response);
    } on io.SocketException catch (error, stackTrace) {
      return _networkFailure(error, stackTrace);
    } on async.TimeoutException catch (error, stackTrace) {
      return _timeoutFailure(error, stackTrace);
    } on io.HttpException catch (error, stackTrace) {
      return _httpTransportFailure(error, stackTrace);
    } on FormatException catch (error, stackTrace) {
      return _formatFailure(error, stackTrace);
    } catch (error, stackTrace) {
      return _unknownFailure(error, stackTrace);
    } finally {
      _stopLoadingIfNeeded();
    }
  }

  RepositoryResult<ApiResponse> _mapHttpResponse(http.Response response) {
    final apiResponse = ApiResponse(
      statusCode: response.statusCode,
      body: response.bodyBytes,
      stringBody: response.body,
      headers: response.headers,
    );

    if (!apiResponse.isSuccess) {
      return Failure(
        HttpException(
          _extractErrorMessage(apiResponse),
          statusCode: apiResponse.statusCode,
          errorCode: _extractErrorCode(apiResponse),
        ),
      );
    }

    return Success(apiResponse);
  }

  String _extractErrorMessage(ApiResponse apiResponse) {
    try {
      final decoded = jsonDecode(apiResponse.stringBody ?? '');
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message']?.toString();
        if (message != null && message.trim().isNotEmpty) {
          return message;
        }
      }
    } catch (_) {}
    return _buildHttpErrorMessage(apiResponse.statusCode);
  }

  String? _extractErrorCode(ApiResponse apiResponse) {
    try {
      final decoded = jsonDecode(apiResponse.stringBody ?? '');
      if (decoded is Map<String, dynamic> && decoded['code'] != null) {
        return decoded['code'].toString();
      }
    } catch (_) {}
    return null;
  }

  String? _encodeBody(HttpMethod method) {
    if (method == HttpMethod.get || postParameters == null) {
      return null;
    }
    if (postParameters is String) {
      return postParameters as String;
    }
    return jsonEncode(postParameters);
  }

  IOClient _createIoClient() {
    final httpClient =
        io.HttpClient(context: io.SecurityContext(withTrustedRoots: false))
          ..badCertificateCallback =
              (io.X509Certificate cert, String host, int port) {
                debugPrint(cert.pem); // certificate pinning certificate
                return true;
              };
    return IOClient(httpClient);
  }

  Failure<ApiResponse>? _validateUrl() {
    final uri = Uri.tryParse(url);
    if (uri == null || !(uri.hasScheme && uri.host.isNotEmpty)) {
      return Failure(
        ParsingException(
          _localize((s) => s.theServerReturnedAnInvalidFormat, 'Invalid URL'),
        ),
      );
    }
    if (!kDebugMode && uri.scheme != 'https') {
      // Difference between http & https ssl? https is certificate
      return const Failure(
        NetworkException('Only HTTPS is allowed in release mode'),
      );
    }
    return null;
  }

  Failure<ApiResponse> _networkFailure(Object error, StackTrace stackTrace) {
    return Failure(
      NetworkException(
        _localize(
          (s) => s.unableToConnectToTheServerPleaseCheckYourInternet,
          'Unable to connect to the server, please check your internet',
        ),
        cause: error,
        stackTrace: stackTrace,
      ),
    );
  }

  Failure<ApiResponse> _timeoutFailure(Object error, StackTrace stackTrace) {
    return Failure(
      TimeoutException(
        _localize(
          (s) => s.theRequestTimedOutPleaseTryAgainLater,
          'The request timed out, please try again later',
        ),
        cause: error,
        stackTrace: stackTrace,
      ),
    );
  }

  Failure<ApiResponse> _httpTransportFailure(
    Object error,
    StackTrace stackTrace,
  ) {
    return Failure(
      NetworkException(
        _localize(
          (s) => s.anUnexpectedErrorOccuredPleaseTryAgain,
          'A network error occurred',
        ),
        cause: error,
        stackTrace: stackTrace,
      ),
    );
  }

  Failure<ApiResponse> _formatFailure(Object error, StackTrace stackTrace) {
    return Failure(
      ParsingException(
        _localize(
          (s) => s.theServerReturnedAnInvalidFormat,
          'The server returned an invalid format',
        ),
        cause: error,
        stackTrace: stackTrace,
      ),
    );
  }

  Failure<ApiResponse> _unknownFailure(Object error, StackTrace stackTrace) {
    return Failure(
      UnknownException(
        _localize(
          (s) => s.anUnexpectedErrorOccuredPleaseTryAgain,
          'An unexpected error occurred, please try again',
        ),
        cause: error,
        stackTrace: stackTrace,
      ),
    );
  }

  String _buildHttpErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return _localize(
          (s) => s.invalidRequestSentToTheServer,
          'Invalid request sent to the server',
        );
      case 401:
        return _localize(
          (s) => s.youAreNotAuthorizedToAccessThisData,
          'You are not authorized to access this data',
        );
      case 403:
        return _localize(
          (s) => s.youAreNotAuthorizedToAccessThisData,
          'You do not have permission to access this resource',
        );
      case 404:
        return _localize(
          (s) => s.sysConfigEndpointWasNotFound,
          'The requested endpoint was not found',
        );
      default:
        return _localize(
          (s) => s.anUnexpectedErrorOccuredPleaseTryAgain,
          'Request failed with status code $statusCode',
        );
    }
  }

  String _localize(String Function(S s) picker, String fallback) {
    final ctx = context;
    if (ctx != null && ctx.mounted) {
      try {
        return picker(S.of(ctx));
      } catch (_) {
        return fallback;
      }
    }
    return fallback;
  }

  void _startLoadingIfNeeded() {
    if (showLoading && context != null && context!.mounted) {
      ProgressHud.shared.startLoading(context!);
    }
  }

  void _stopLoadingIfNeeded() {
    if (showLoading) {
      ProgressHud.shared.stopLoading();
    }
  }

  void _debugPrint(String from) {
    if (!kDebugMode) return;
    debugPrint(
      '==============================================\n'
      'From : $from\n'
      'url = $url\n'
      'headers = $_headers\n'
      'postBody = $postParameters\n'
      '==============================================',
    );
  }

  void _debugPrintWithResponse(String from, http.Response response) {
    if (!kDebugMode) return;
    debugPrint(
      '==============================================\n'
      'From : $from\n'
      'url = $url\n'
      'headers = $_headers\n'
      'postBody = $postParameters\n'
      'statusCode = ${response.statusCode}\n'
      'response body = ${response.body}\n'
      '==============================================',
    );
  }
}
