import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../configuration/app_config.dart';
import '../model/login_response.dart';

abstract class LoginRepository {
  Future<RepositoryResult<UserModel>> login({
    required BuildContext context,
    required String email,
    required String password,
    bool showLoading = true,
  });
}

class ApiLoginRepository extends LoginRepository {
  @override
  Future<RepositoryResult<UserModel>> login({
    required BuildContext context,
    required String email,
    required String password,
    bool showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.login,
      context: context,
      showLoading: showLoading,
      postParameters: {"email": email, "password": password},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  //decode
  RepositoryResult<UserModel> _parse(String body, BuildContext context) {
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
      final response = LoginResponse.fromJson(json);
      if (response.success! && response.user != null) {
        return Success(response.user!);
      }
      return Failure(
        MappingException(
          response.message?.isNotEmpty == true
              ? response.message!
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

class DemoLoginRepository implements LoginRepository {
  @override
  Future<RepositoryResult<UserModel>> login({
    required BuildContext context,
    required String email,
    required String password,
    bool showLoading = true,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return Success(
      UserModel(
        accessToken: 'Demo-Token',
        tokenType: 'Bearer',
        user: User(
          email: 'sara@gmail.com',
          fullName: 'Sara Mistarihi',
          id: 1,
          zipCode: 11234,
        ),
      ),
    );
  }
}

LoginRepository createLoginRepository() {
  return AppConfig().isDemo ? DemoLoginRepository() : ApiLoginRepository();
}
