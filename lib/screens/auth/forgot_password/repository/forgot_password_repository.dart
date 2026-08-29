import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/screens/auth/register/model/generic_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../generated/l10n.dart';

abstract class ForgotPasswordRepository {
  Future<RepositoryResult<GenericResponse>> resetPassword({
    required BuildContext context,
    required String email,
    required String newPassword,
    required String otpToken,
    bool showLoading = true,
  });
}

class ApiForgotPasswordRepository extends ForgotPasswordRepository {
  @override
  Future<RepositoryResult<GenericResponse>> resetPassword({
    required BuildContext context,
    required String email,
    required String newPassword,
    required String otpToken,
    bool showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.resetPassword,
      context: context,
      showLoading: showLoading,
      postParameters: {
        "email": email,
        "newPassword": newPassword,
        "otpToken": otpToken,
      },
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
        return Failure(MappingException('Unexpected reset password response'));
      }
      final response = GenericResponse.fromJson(json);
      if (response.success && response.code == 200) {
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

class DemoForgotPasswordRepository extends ForgotPasswordRepository {
  @override
  Future<RepositoryResult<GenericResponse>> resetPassword({
    required BuildContext context,
    required String email,
    required String newPassword,
    required String otpToken,
    bool showLoading = true,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return Success(
      GenericResponse(success: true, code: 200, message: 'Password Reset'),
    );
  }
}

ForgotPasswordRepository createForgotPasswordRepository() {
  return AppConfig().isDemo
      ? DemoForgotPasswordRepository()
      : ApiForgotPasswordRepository();
}
