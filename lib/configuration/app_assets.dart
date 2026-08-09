class AppAssets {
  AppAssets._private();

  static final AppAssets _shared = AppAssets._private();

  factory AppAssets() => _shared;

  String introScreen1 = 'assets/intro/screen1.json';
  String introScreen2 = 'assets/intro/screen2.json';
  String introScreen3 = 'assets/intro/screen3.json';

  String nameIconTextField = 'assets/text_field_icons/ic_name.svg';
  String emailIconTextField = 'assets/text_field_icons/ic_mail.svg';
  String passwordIconTextField = 'assets/text_field_icons/ic_pass.svg';
  String zipIconTextField = 'assets/text_field_icons/ic_zip.svg';
  String otpIconTextField = 'assets/text_field_icons/ic_otp.svg';

  String closeIcon = 'assets/common/ic_close.svg';
  String copyRightIcon = 'assets/common/copy-rights.svg';

  String emailBottomSheet = 'assets/dialogs/check_email.svg';
  String successDialog = 'assets/dialogs/success-dialog.json';
  String errorDialog = 'assets/dialogs/error_dialog.svg';

  String scanQrCodeAction = 'assets/home_icons/scan_qr_code_action.svg';
  String loadingSplashLogo = 'assets/home_icons/loading.json';
}
