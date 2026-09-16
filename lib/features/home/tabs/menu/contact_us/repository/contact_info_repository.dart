import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/contact_us/model/contact_info_model.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

abstract class ContactInfoRepository {
  Future<RepositoryResult<ContactInfoModel>> contactUsInfo({
    required BuildContext context,
    bool showLoading = false,
  });
}

class ApiContactInfoRepository extends ContactInfoRepository {
  @override
  Future<RepositoryResult<ContactInfoModel>> contactUsInfo({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.contactUsInfo,
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<ContactInfoModel> _parse(String body, BuildContext context) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected Contact info response'));
      }
      final response = ContactInfoModel.fromJson(json);
      if (response.success == true && response.result != null) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message?.isNotEmpty == true
              ? response.message!
              : 'Server return unsuccessful response',
        ),
      );
    } catch (error, stackTrace) {
      return Failure(
        UnknownException(
          'Unexpected error occurred, plz try again',
          cause: error,
          stackTrace: stackTrace,
        ),
      );
    }
  }
}

class DemoContactInfoRepository extends ContactInfoRepository {
  @override
  Future<RepositoryResult<ContactInfoModel>> contactUsInfo({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      ContactInfoModel(
        success: true,
        code: 200,
        result: Info(
          phoneNumber: '079xxxxxxx',
          email: 'example@gmail.com',
          facebook: '',
          instagram: '',
          tiktok: '',
          twitter: '',
          youtube: '',
          websiteUrl: '',
          whatsapp: '',
        ),
      ),
    );
  }
}

ContactInfoRepository createContactInfoRepository() {
  return AppConfig().isDemo
      ? DemoContactInfoRepository()
      : ApiContactInfoRepository();
}
