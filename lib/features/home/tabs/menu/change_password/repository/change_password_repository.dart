import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/features/auth/register/model/generic_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../../../configuration/app_config.dart';
import '../../../../../../generated/l10n.dart';
import '../../../../../../utils/helpers/common/exception/repository_exception.dart';

abstract class ChangePasswordRepository {
  Future<RepositoryResult<GenericResponse>> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    bool showLoading = false,
  });
}

class ApiChangePasswordRepository extends ChangePasswordRepository {
  @override
  Future<RepositoryResult<GenericResponse>> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.changePassword,
      context: context,
      showLoading: showLoading,
      postParameters: {"oldPassword": oldPassword, "newPassword": newPassword},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<GenericResponse> _parse(String body, BuildContext context) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return const Failure(
          MappingException('Unexpected change password response'),
        );
      }
      final response = GenericResponse.fromJson(json);
      if (response.code == 200 && response.success) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message.isNotEmpty
              ? response.message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
          errorCode: response.code.toString(),
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        UnknownException(
          S.of(context).anUnexpectedErrorOccuredPleaseTryAgain,
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}

class DemoChangePasswordRepository extends ChangePasswordRepository {
  @override
  Future<RepositoryResult<GenericResponse>> changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
    bool showLoading = true,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success(
      GenericResponse(success: true, code: 200, message: 'Password changed'),
    );
  }
}

ChangePasswordRepository createChangePasswordRepository() {
  return AppConfig().isDemo
      ? DemoChangePasswordRepository()
      : ApiChangePasswordRepository();
}
