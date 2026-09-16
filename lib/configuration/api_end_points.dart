const version = 'v1/';

String baseUrl = 'https://trainees.vinsweep.foryo.lat/api/';

class ApiEndPoints {
  //static final String sysConfig = baseUrl+version+'system-config';

  static final String sysConfig = '$baseUrl${version}system-config';
  static final String generateOtp = '$baseUrl${version}auth/generate-otp';
  static final String verifyOtp = '$baseUrl${version}auth/verify-otp';
  static final String signup = '$baseUrl${version}auth/signup';
  static final String login = '$baseUrl${version}auth/login';
  static final String changePassword = '$baseUrl${version}auth/change-password';
  static final String resetPassword = '$baseUrl${version}auth/reset-password';
  static final String contactUsInfo =
      '$baseUrl${version}setting-config/contact-us-info';
  static final String updateUser = '$baseUrl${version}users/update';
}
