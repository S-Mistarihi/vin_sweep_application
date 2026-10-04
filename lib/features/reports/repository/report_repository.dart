import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';

import '../../../configuration/api_end_points.dart';
import '../../../generated/l10n.dart';
import '../../../utils/helpers/common/repository_result.dart';
import '../../../utils/helpers/http/http_wrapper.dart';
import '../model/report_payment_intent_model.dart';
import '../model/pdf_report_response.dart';

abstract class ReportRepository {
  Future<RepositoryResult<ReportPaymentIntent>> createPdfPaymentIntent({
    required BuildContext context,
    required String vin,
    String? paymentMethodId,
    bool savePaymentMethod = false,
    String? discountCouponCode,
    bool showLoading = false,
  });

  Future<RepositoryResult<PdfReportDetails>> confirmPdfPayment({
    required BuildContext context,
    required String paymentIntentId,
    required String vin,
    bool showLoading = false,
  });

  Future<RepositoryResult<PdfReportDetails>> generateReport({
    required BuildContext context,
    required String vin,
    String? paymentMethodId,
    bool savePaymentMethod = false,
    String? discountCouponCode,
    bool showLoading = false,
  });

  Future<RepositoryResult<List<PdfReportDetails>>> getReportsByVin({
    required BuildContext context,
    required String vin,
    bool showLoading = false,
  });

  Future<RepositoryResult<List<PdfReportDetails>>> getMyReports({
    required BuildContext context,
    bool showLoading = false,
  });
}

class ApiReportRepository extends ReportRepository {
  //
  @override
  Future<RepositoryResult<ReportPaymentIntent>> createPdfPaymentIntent({
    required BuildContext context,
    required String vin,
    String? paymentMethodId,
    bool savePaymentMethod = false,
    String? discountCouponCode,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.createPdfPaymentIntent,
      context: context,
      showLoading: showLoading,
      postParameters: {
        "vin": vin,
        "paymentMethodId": paymentMethodId,
        "savePaymentMethod": savePaymentMethod,
        "discountCouponCode": discountCouponCode,
      },
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parsePayIntent(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<PdfReportDetails>> confirmPdfPayment({
    required BuildContext context,
    required String paymentIntentId,
    required String vin,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.confirmPdfPayment,
      context: context,
      showLoading: showLoading,
      postParameters: {"paymentIntentId": paymentIntentId, "vin": vin},
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<PdfReportDetails>> generateReport({
    required BuildContext context,
    required String vin,
    String? paymentMethodId,
    bool savePaymentMethod = false,
    String? discountCouponCode,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.generatePdfReport,
      context: context,
      showLoading: showLoading,
      postParameters: {
        "vin": vin,
        "paymentMethodId": paymentMethodId,
        "savePaymentMethod": savePaymentMethod,
        "discountCouponCode": discountCouponCode,
      },
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parse(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<List<PdfReportDetails>>> getReportsByVin({
    required BuildContext context,
    required String vin,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getPdfReportsByVin(vin),
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseList(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<List<PdfReportDetails>>> getMyReports({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getPdfReport,
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseList(data.stringBody ?? '', context);
    }
  }

  RepositoryResult<ReportPaymentIntent> _parsePayIntent(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      final response = ReportPaymentIntentModel.fromJson(json);
      if (response.success == true) {
        return Success(response.result);
      }
      return Failure(
        MappingException(
          response.message.isNotEmpty == true
              ? response.message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
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

  RepositoryResult<PdfReportDetails> _parse(String body, BuildContext context) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      final response = PdfReportResponse.fromJson(json);
      if (response.success == true) {
        return Success(response.result);
      }
      return Failure(
        MappingException(
          response.message.isNotEmpty == true
              ? response.message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
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

  RepositoryResult<List<PdfReportDetails>> _parseList(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      if (json['success'] == true) {
        return Success(
          (json['result'] as List? ?? [])
              .map((e) => PdfReportDetails.fromJson(e as Map<String, dynamic>))
              .toList(),
        );
      }

      final message = (json['message'] ?? '').toString();
      return Failure(
        MappingException(
          message.isNotEmpty
              ? message
              : S.of(context).theServerReturnedAnUnsuccessfulResponse,
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

class DemoReportRepository extends ReportRepository {
  @override
  Future<RepositoryResult<ReportPaymentIntent>> createPdfPaymentIntent({
    required BuildContext context,
    required String vin,
    String? paymentMethodId,
    bool savePaymentMethod = false,
    String? discountCouponCode,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      ReportPaymentIntent(
        paymentIntentId: 'pi_demo',
        clientSecret: 'pi_demo_secret',
        vin: vin,
        planType: 'BASIC',
        requiresPayment: true,
        message: '',
      ),
    );
  }

  @override
  Future<RepositoryResult<PdfReportDetails>> confirmPdfPayment({
    required BuildContext context,
    required String paymentIntentId,
    required String vin,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      PdfReportDetails(
        reportId: DateTime.now().millisecondsSinceEpoch,
        vin: vin,
        fileName: 'report_$vin.pdf',
        downloadUrl: 'https://example.com/report.pdf',
        fileSize: 245000,
        generatedAt: DateTime.now(),
        downloadCount: 0,
      ),
    );
  }

  @override
  Future<RepositoryResult<PdfReportDetails>> generateReport({
    required BuildContext context,
    required String vin,
    String? paymentMethodId,
    bool savePaymentMethod = false,
    String? discountCouponCode,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(
      PdfReportDetails(
        reportId: DateTime.now().millisecondsSinceEpoch,
        vin: vin,
        fileName: 'report_$vin.pdf',
        downloadUrl: 'https://example.com/report.pdf',
        fileSize: 245000,
        generatedAt: DateTime.now(),
        downloadCount: 0,
      ),
    );
  }

  @override
  Future<RepositoryResult<List<PdfReportDetails>>> getReportsByVin({
    required BuildContext context,
    required String vin,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success(<PdfReportDetails>[]);
  }

  @override
  Future<RepositoryResult<List<PdfReportDetails>>> getMyReports({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return Success([
      PdfReportDetails(
        reportId: 1,
        vin: '4Y1SL65848Z411439',
        fileName: 'report_4Y1SL65848Z411439.pdf',
        downloadUrl: 'https://example.com/1.pdf',
        generatedAt: DateTime(2025, 6, 20),
      ),
      PdfReportDetails(
        reportId: 2,
        vin: '5B2QW9022A3911911',
        fileName: 'report_5B2QW9022A3911911.pdf',
        downloadUrl: 'https://example.com/2.pdf',
        generatedAt: DateTime(2025, 6, 20),
      ),
      PdfReportDetails(
        reportId: 3,
        vin: '5B2QW9022A3911912',
        fileName: 'report_5B2QW9022A3911912.pdf',
        downloadUrl: 'https://example.com/3.pdf',
        generatedAt: DateTime(2025, 6, 12),
      ),
    ]);
  }
}

ReportRepository createReportRepository() {
  return AppConfig().isDemo ? DemoReportRepository() : ApiReportRepository();
}
