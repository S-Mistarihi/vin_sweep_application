import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/screens/auth/register/model/generic_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../configuration/app_config.dart';
import '../../../../generated/l10n.dart';
import '../../../../utils/helpers/common/exception/repository_exception.dart';

abstract class RegisterRepository {
  Future<RepositoryResult<GenericResponse>> register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String zipCode,
    required String otpToken,
    bool showLoading = true,
  });
}

class ApiRegisterRepository extends RegisterRepository {
  @override
  Future<RepositoryResult<GenericResponse>> register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String zipCode,
    required String otpToken,
    bool showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.signup,
      context: context,
      showLoading: showLoading,
      useAuthorization: false,
      postParameters: {
        'email': email,
        'password': password,
        'fullName': name,
        'zipCode': zipCode,
        'otpToken': otpToken,
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
      if (body.trim().isEmpty) {
        return Failure(
          ParsingException(S.of(context).theServerReturnedAnInvalidFormat),
        );
      }
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected login response structure'));
      }
      final response = GenericResponse.fromJson(json);
      if (response.success && response.code == 200) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message.isNotEmpty == true
              ? response.message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
        ),
      );
    } on FormatException catch (error, stackTrace) {
      return Failure(
        ParsingException(
          S.of(context).theServerReturnedAnInvalidFormat,
          cause: error,
          stackTrace: stackTrace,
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

class DemoRegisterRepository extends RegisterRepository {
  @override
  Future<RepositoryResult<GenericResponse>> register({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String zipCode,
    required String otpToken,
    bool showLoading = true,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success(
      GenericResponse(success: true, code: 200, message: 'Registered'),
    );
  }
}

RegisterRepository createRegisterRepository() {
  return AppConfig().isDemo
      ? DemoRegisterRepository()
      : ApiRegisterRepository();
}
