import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/api/system_config/model/system_config_response.dart';

import '../../../generated/l10n.dart';
import '../../../utils/helpers/common/exception/repository_exception.dart';
import '../../../utils/helpers/common/repository_result.dart';
import '../../../utils/helpers/http/http_wrapper.dart';

abstract class SystemConfigRepository {
  Future<RepositoryResult<SystemConfigResponse>> getSystemConfig({
    required BuildContext context,
  });
}

class ApiSystemConfigRepository extends SystemConfigRepository {
  final String url;
  final Duration timeout;
  final String? token;

  ApiSystemConfigRepository({
    required this.url,
    this.timeout = const Duration(seconds: 60),
    this.token,
  });

  @override
  Future<RepositoryResult<SystemConfigResponse>> getSystemConfig({
    required BuildContext context,
  }) async {
    final result = await HttpWrapper(
      url: url,
      context: context,
      timeout: timeout,
      showLoading: false,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        if (!context.mounted) {
          return const Failure(
            UnknownException('Context is no longer available'),
          );
        }
        return _parseResponse(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<SystemConfigResponse> _parseResponse(
    String stringBody,
    BuildContext context,
  ) {
    try {
      if (stringBody.trim().isEmpty) {
        return const Failure(
          ParsingException('the server returned an empty message'),
        );
      }

      final dynamic json = jsonDecode(stringBody);

      if (json is! Map<String, dynamic>) {
        return const Failure(
          MappingException('The server response has unexpected structure'),
        );
      }

      final model = SystemConfigResponse.fromRawJson(stringBody);

      if (model.success != true) {
        return Failure(
          MappingException(
            model.message.isNotEmpty
                ? model.message
                : S.of(context).theServerReturnedAnUnsuccessfulResponse,
          ),
        );
      }

      if (model.result == null) {
        return Failure(
          MappingException(S.of(context).theSysConfigDataIsMissing),
        );
      }

      return Success(model);
    } on FormatException catch (error, stackTrace) {
      return Failure(
        ParsingException(
          S.of(context).failedToParseSysConfigResponse,
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    } on TypeError catch (error, stackTrace) {
      return Failure(
        MappingException(
          S.of(context).theSysConfigResponseDowsNotMatchTheExpectedModel,
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        UnknownException(
          'an unexpected error occured while processing ',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}

class DemoSystemConfigRepository extends SystemConfigRepository {
  @override
  Future<RepositoryResult<SystemConfigResponse>> getSystemConfig({
    required BuildContext context,
  }) async {
    return Success(
      SystemConfigResponse(
        code: 200,
        message: 'Success',
        success: true,
        result: [
          SystemConfigModel(key: 'test', value: 'test2'),
          SystemConfigModel(key: 'test', value: 'test2'),
          SystemConfigModel(key: 'test', value: 'test2'),
          SystemConfigModel(key: 'test', value: 'test2'),
          SystemConfigModel(key: 'test', value: 'test2'),
          SystemConfigModel(key: 'test', value: 'test2'),
          SystemConfigModel(key: 'test', value: 'test2'),
        ],
      ),
    );
  }
}
