const version = 'v1/';

String baseUrl = 'https://trainees.vinsweep.foryo.lat/api/';

class ApiEndPoints {
  //static final String sysConfig = baseUrl+version+'system-config';

  static final String sysConfig = '$baseUrl${version}system-config';
  static final String generateOtp = '$baseUrl${version}auth/generate-otp';
  static final String verifyOtp = '$baseUrl${version}auth/verify-otp';
  static final String signup = '$baseUrl${version}auth/signup';
  static final String login = '$baseUrl${version}auth/login';
  static final String resetPassword = '$baseUrl${version}auth/reset-password';

  //menu api
  static final String changePassword = '$baseUrl${version}auth/change-password';
  static final String contactUsInfo =
      '$baseUrl${version}setting-config/contact-us-info';
  static final String updateUser = '$baseUrl${version}users/update';
  static final String getPlans = '$baseUrl${version}plans';
  static final String getCurrentUserPlan = '$baseUrl${version}users/current';

  static String setAutoRenew(bool autoRenew) =>
      '$baseUrl${version}plans/auto-renew?autoRenew=$autoRenew';

  static final String subscribePlan = '$baseUrl${version}plans/subscribe';
  static final String createSubscriptionPaymentIntent =
      '$baseUrl${version}plans/subscribe/create-payment-intent';
  static final String confirmPlanPayment =
      '$baseUrl${version}plans/confirm-payment';

  static String getPaymentMethod(bool forceRefresh) =>
      '$baseUrl${version}payment/my-payment-methods?forceRefresh=$forceRefresh';
  static final String setDefaultPaymentMethod =
      '$baseUrl${version}payment/set-default-payment-method';
  static final String deletePaymentMethod =
      '$baseUrl${version}payment/delete-payment-method';
  static final String getPaymentHistory =
      '$baseUrl${version}payment/my-payment-history';
  static final String setupIntent = '$baseUrl${version}payment/setup-intent';
  static final String confirmSetupIntent =
      '$baseUrl${version}payment/confirm-setup-intent';

  //home FAB
  static final String getUserSearchHistory =
      '$baseUrl${version}users/get-user-search-history';
  static final String getUserPlanHistory = '$baseUrl${version}users/history';
  static final String scanVin = '$baseUrl${version}vehicle';

  //report
  static final String createPdfPaymentIntent =
      '$baseUrl${version}vehicle/create-pdf-report-payment-intent';
  static final String confirmPdfPayment =
      '$baseUrl${version}vehicle/confirm-pdf-report-payment';
  static final String generatePdfReport =
      '$baseUrl${version}vehicle/generate-pdf-report';

  static String getPdfReportsByVin(String vin) =>
      '$baseUrl${version}pdf-reports/vin/$vin';

  //coupon
  static final String validateCoupon =
      '$baseUrl${version}payment/validate-discount-coupon';
}
