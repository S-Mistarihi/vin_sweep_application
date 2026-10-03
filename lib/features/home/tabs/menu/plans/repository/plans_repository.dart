import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vin_sweep_application/configuration/api_end_points.dart';
import 'package:vin_sweep_application/configuration/app_config.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/model/plans_response.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/utils/helpers/common/exception/repository_exception.dart';
import 'package:vin_sweep_application/utils/helpers/common/repository_result.dart';
import 'package:vin_sweep_application/utils/helpers/http/http_wrapper.dart';

import '../../../../../auth/register/model/generic_response.dart';
import '../model/plan_payment_intent_response.dart';
import '../model/user_plan_response.dart';

abstract class PlansRepository {
  Future<RepositoryResult<UserPlanResponse?>> getCurrentUserPlan({
    required BuildContext context,
    bool showLoading = false,
  });

  Future<RepositoryResult<PlansResponse>> getPlans({
    required BuildContext context,
    bool showLoading = false,
  });

  Future<RepositoryResult<GenericResponse>> setAutoRenew({
    required BuildContext context,
    required bool autoRenew,
    bool showLoading = false,
  });

  //pay with saved card
  Future<RepositoryResult<UserPlanResponse>> subscribe({
    required BuildContext context,
    required int planId,
    required String paymentMethodId,
    bool saveCard = false,
    bool autoRenew = false,
    bool showLoading = true,
  });

  //pay with new card
  Future<RepositoryResult<PaymentIntentData>> createPaymentIntent({
    required BuildContext context,
    required int planId,
    bool saveCard = false,
    bool autoRenew = false,
    bool showLoading = false,
  });

  Future<RepositoryResult<UserPlanResponse>> confirmPayment({
    required BuildContext context,
    required String paymentIntentId,
    String description = '',
    bool showLoading = false,
  });
}

class ApiPlansRepository extends PlansRepository {
  //
  @override
  Future<RepositoryResult<UserPlanResponse?>> getCurrentUserPlan({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getCurrentUserPlan,
      context: context,
      showLoading: showLoading,
    ).get();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseCurrentPlan(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<PlansResponse>> getPlans({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.getPlans,
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

  //
  @override
  Future<RepositoryResult<GenericResponse>> setAutoRenew({
    required BuildContext context,
    required bool autoRenew,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.setAutoRenew(autoRenew),
      context: context,
      showLoading: showLoading,
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseAutoRenew(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<UserPlanResponse>> subscribe({
    required BuildContext context,
    required int planId,
    required String paymentMethodId,
    bool saveCard = false,
    bool autoRenew = false,
    bool showLoading = true,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.subscribePlan,
      context: context,
      showLoading: showLoading,
      postParameters: {
        "planId": planId,
        "paymentMethodId": paymentMethodId,
        "saveCard": saveCard,
        "autoRenew": autoRenew,
      },
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseSubscription(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<PaymentIntentData>> createPaymentIntent({
    required BuildContext context,
    required int planId,
    bool saveCard = false,
    bool autoRenew = false,
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.createSubscriptionPaymentIntent,
      context: context,
      showLoading: showLoading,
      postParameters: {
        "planId": planId,
        "saveCard": saveCard,
        "autoRenew": autoRenew,
      },
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parsePaymentIntent(data.stringBody ?? '', context);
    }
  }

  //
  @override
  Future<RepositoryResult<UserPlanResponse>> confirmPayment({
    required BuildContext context,
    required String paymentIntentId,
    String description = '',
    bool showLoading = false,
  }) async {
    final result = await HttpWrapper(
      url: ApiEndPoints.confirmPlanPayment,
      context: context,
      showLoading: showLoading,
      postParameters: {
        "paymentIntentId": paymentIntentId,
        "description": description,
      },
    ).post();

    switch (result) {
      case Failure(:final exception):
        return Failure(exception);
      case Success(:final data):
        return _parseSubscription(data.stringBody ?? '', context);
    }
  }

  ///------------------------------------------------------------------------
  //
  RepositoryResult<UserPlanResponse?> _parseCurrentPlan(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      final response = GenericResponse.fromJson(json);
      if (!response.success) {
        return Failure(
          MappingException(
            response.message.isNotEmpty
                ? response.message
                : S.of(context).theServerReturnedAnUnsuccessfulResponse,
            errorCode: response.code.toString(),
          ),
        );
      }

      final result = json["result"];
      if (result is Map<String, dynamic> && result.isNotEmpty) {
        return Success(UserPlanResponse.fromJson(result));
      }
      return Success(null);
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

  RepositoryResult<PlansResponse> _parse(String body, BuildContext context) {
    try {
      if (body.trim().isEmpty) {
        return Failure(
          ParsingException(S.of(context).theServerReturnedAnInvalidFormat),
        );
      }
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected plan response structure'));
      }
      final response = PlansResponse.fromJson(json);
      if (response.success == true && response.plans != null) {
        return Success(response);
      }
      return Failure(
        MappingException(
          response.message?.isNotEmpty == true
              ? response.message!
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

  RepositoryResult<GenericResponse> _parseAutoRenew(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      final response = GenericResponse.fromJson(json);
      if (response.success) {
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

  RepositoryResult<UserPlanResponse> _parseSubscription(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      final response = GenericResponse.fromJson(json);
      final result = json["result"];
      if (response.success && result is Map<String, dynamic>) {
        return Success(UserPlanResponse.fromJson(result));
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

  RepositoryResult<PaymentIntentData> _parsePaymentIntent(
    String body,
    BuildContext context,
  ) {
    try {
      final json = jsonDecode(body);
      if (json is! Map<String, dynamic>) {
        return Failure(MappingException('Unexpected response structure'));
      }

      final response = PlanPaymentIntentResponse.fromJson(json);
      if (response.success &&
          response.result.clientSecret.isNotEmpty &&
          response.result.paymentIntentId.isNotEmpty) {
        return Success(response.result);
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

class DemoPlansRepository extends PlansRepository {
  @override
  Future<RepositoryResult<UserPlanResponse?>> getCurrentUserPlan({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(
      UserPlanResponse(
        id: 1,
        userId: 1,
        plan: PlanModel(id: 2, name: 'Starter Plan', reportsCount: 5),
        reportsRemaining: 2,
        generatedReportsCount: 3,
        status: 'ACTIVE',
        autoRenew: true,
        startsAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      ),
    );
  }

  @override
  Future<RepositoryResult<PlansResponse>> getPlans({
    required BuildContext context,
    bool showLoading = false,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    return Success(
      PlansResponse(
        success: true,
        code: 200,
        message: 'Get Plans Successfully',
        plans: [
          PlanModel(
            id: 1,
            name: 'Basic Plan',
            planType: 'BASIC',
            price: 10,
            reportPrice: 10,
            reportsCount: 1,
            validityDays: 0,
            mostPopular: false,
            active: true,
            headlinePrimary: 'Basic Plan',
            headlineSecondary: 'Unlimited Reports',
            priceLabel: '\$10',
            priceSublabel: 'Per Report',
            features: [
              'No Monthly Subscription',
              'Full report content',
              'VIN must be entered manually',
              'VIN must be entered manually',
            ],
          ),
          PlanModel(
            id: 2,
            name: 'Starter Plan',
            planType: 'STARTER',
            price: 25,
            reportPrice: 5,
            reportsCount: 5,
            validityDays: 30,
            mostPopular: true,
            active: true,
            headlinePrimary: 'Starter Plan',
            headlineSecondary: '5 Reports',
            priceLabel: '\$25',
            priceSublabel: '0 Per Report',
            features: [
              'Expires in 30 days',
              'Saved \$25',
              'VIN must be entered manually or by scan',
              'Access to report history after viewing.',
            ],
          ),
        ],
      ),
    );
  }

  @override
  Future<RepositoryResult<GenericResponse>> setAutoRenew({
    required BuildContext context,
    required bool autoRenew,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(
      GenericResponse(success: true, code: 200, message: 'Auto renew updated'),
    );
  }

  @override
  Future<RepositoryResult<UserPlanResponse>> subscribe({
    required BuildContext context,
    required int planId,
    required String paymentMethodId,
    bool saveCard = false,
    bool autoRenew = false,
    bool showLoading = true,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success(
      UserPlanResponse(
        id: 1,
        userId: 1,
        plan: PlanModel(id: planId, name: 'Demo Plan', reportsCount: 5),
        reportsRemaining: 5,
        generatedReportsCount: 0,
        status: 'ACTIVE',
        autoRenew: autoRenew,
        startsAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      ),
    );
  }

  @override
  Future<RepositoryResult<PaymentIntentData>> createPaymentIntent({
    required BuildContext context,
    required int planId,
    bool saveCard = false,
    bool autoRenew = false,
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(
      PaymentIntentData(
        paymentIntentId: 'pi_demo',
        clientSecret: 'pi_demo_secret',
        message: '',
      ),
    );
  }

  @override
  Future<RepositoryResult<UserPlanResponse>> confirmPayment({
    required BuildContext context,
    required String paymentIntentId,
    String description = '',
    bool showLoading = false,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Success(
      UserPlanResponse(
        id: 1,
        userId: 1,
        plan: PlanModel(id: 1, name: 'Demo Plan', reportsCount: 5),
        reportsRemaining: 5,
        generatedReportsCount: 0,
        status: 'ACTIVE',
        autoRenew: true,
        startsAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      ),
    );
  }
}

PlansRepository createPlansRepository() {
  return AppConfig().isDemo ? DemoPlansRepository() : ApiPlansRepository();
}
