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
  static final String getPaymentMethod =
      '$baseUrl${version}payment/my-payment-methods?forceRefresh=false';
  static final String setDefaultPaymentMethod =
      '$baseUrl${version}payment/set-default-payment-method';
  static final String deletePaymentMethod =
      '$baseUrl${version}payment/delete-payment-method';
  static final String getPaymentHistory =
      '$baseUrl${version}payment/my-payment-history';

  //home FAB
  static final String scanVin = '$baseUrl${version}vehicle';
}
