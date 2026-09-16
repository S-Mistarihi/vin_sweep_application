import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/features/auth/login/model/login_response.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

abstract class ProfileRepository {
  Future<RepositoryResult<LoginResponse>> updateUser({
    required BuildContext context,
    required String fullName,
    required String phoneNumber,
    required int zipCode,
    showLoading = true,
  });
}

class ApiProfileRepository extends ProfileRepository {
  @override
  Future<RepositoryResult<LoginResponse>> updateUser({
    required BuildContext context,
    required String fullName,
    required String phoneNumber,
    required int zipCode,
    showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.updateUser,
      context: context,
      showLoading: showLoading,
      postParameters: {
        "fullName": fullName,
        "zipCode": zipCode,
        "phoneNumber": phoneNumber,
      },
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<LoginResponse> _parse(String body, BuildContext context) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('unexpected update user response'));
      }
      final response = LoginResponse.fromJson(json);
      if (response.success == true && response.user != null) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message?.isNotEmpty == true
              ? response.message!
              : 'Server returned unsuccessful response',
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        UnknownException(
          'Unexpected error occured, plz try again',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}

class DemoProfileRepository extends ProfileRepository {
  @override
  Future<RepositoryResult<LoginResponse>> updateUser({
    required BuildContext context,
    required String fullName,
    required String phoneNumber,
    required int zipCode,
    showLoading = true,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return Success(
      LoginResponse(
        success: true,
        code: 0,
        message: 'User updated successfully',
        user: UserModel(
          accessToken: 'demo_token',
          tokenType: 'Bearer',
          user: User(
            id: 1,
            fullName: fullName,
            email: 'example@gmail.com',
            zipCode: zipCode,
            phoneNumber: '079xxxxxxx',
            lastLogin: DateTime.now().toIso8601String(),
          ),
        ),
      ),
    );
  }
}

ProfileRepository createProfileRepository() {
  return AppConfig().isDemo ? DemoProfileRepository() : ApiProfileRepository();
}
