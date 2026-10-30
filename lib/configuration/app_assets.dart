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
  String eyeIconTextField = 'assets/text_field_icons/ic-unhide.svg';
  String eyeHideIconTextField = 'assets/text_field_icons/ic-hide.svg';

  String closeIcon = 'assets/common/ic_close.svg';
  String copyRightIcon = 'assets/common/copy-rights.svg';
  String arrowIcon = 'assets/common/ic-arrow.svg';
  String backIcon = 'assets/common/ic-back.svg';

  String searchJsonIcon = 'assets/scan-vin/search.json';
  String noReport = 'assets/scan-vin/no_report.svg';

  String emailBottomSheet = 'assets/dialogs/check_email.svg';
  String successDialog = 'assets/dialogs/success-dialog.json';
  String errorDialog = 'assets/dialogs/error_dialog.svg';

  String scanQrCodeAction = 'assets/home_icons/scan_qr_code_action.svg';
  String scanQrCodeWithAnimation =
      'assets/home_icons/scan_qr_code_with_animation.svg';
  String closeScanQrCodeAction = 'assets/FAB/close_scan_qr_code_action.svg';
  String loadingSplashLogo = 'assets/home_icons/loading.json';
  String scanFab = 'assets/FAB/scan.svg';
  String enterFab = 'assets/FAB/Enter.svg';
  String uploadFab = 'assets/FAB/upload.svg';
  String rescanIcon = 'assets/scan-vin/ic-scan.svg';
  String blueFileIcon = 'assets/home_icons/blue_file_ic.svg';
  String purpleFileIcon = 'assets/home_icons/purple_file_ic.svg';
  String greenFileIcon = 'assets/home_icons/green_file_ic.svg';
  String holdPremiumIcon = 'assets/home_icons/hold__premium_home_ic.svg';
  String subscribePremiumIcon =
      'assets/home_icons/subscription_premium_home_ic.svg';
  String carTotalSweep = 'assets/home_icons/car_total_sweep.svg';
  String emptyHomeScreen = 'assets/home_icons/empty_home.svg';
  String searchIcon = 'assets/home_icons/ic-search.svg';
  String homeIcon = 'assets/home_icons/Ic-Home.svg';
  String menuIcon = 'assets/home_icons/ic-menu.svg';

  String contactUsIcon = 'assets/menu_icons/ic -contact us.svg';
  String aboutUsIcon = 'assets/menu_icons/ic-about us.svg';
  String linkIcon = 'assets/menu_icons/ic-link.svg';
  String logoutIcon = 'assets/menu_icons/ic-logout.svg';
  String paymentIcon = 'assets/menu_icons/ic-payment.svg';
  String plansIcon = 'assets/menu_icons/ic-plans.svg';
  String privacyIcon = 'assets/menu_icons/ic-privacy.svg';
  String profileIcon = 'assets/menu_icons/ic-profile.svg';
  String refundIcon = 'assets/menu_icons/ic-refund.svg';
  String scanHistoryIcon = 'assets/menu_icons/ic-scan history.svg';
  String termsIcon = 'assets/menu_icons/ic-terms.svg';
  String passwordMenuIcon = 'assets/menu_icons/ic-pass.svg';
  String seperator = 'assets/menu_icons/Seperator.svg';

  String icPhone = 'assets/contact-us/ic - phone.svg';
  String icMail = 'assets/contact-us/ic-mail.svg';
  String icWhats = 'assets/contact-us/ic - whatsapp.svg';
  String icWebsite = 'assets/contact-us/ic-website.svg';
  String facebook = 'assets/contact-us/facebook.svg';
  String instagram = 'assets/contact-us/instagram.svg';
  String tiktok = 'assets/contact-us/tiktok.svg';
  String x = 'assets/contact-us/x.svg';
  String youtube = 'assets/contact-us/youtube.svg';

  String payCard = 'assets/payment/card.svg';
  String payMenuIcon = 'assets/payment/ic-menu.svg';
  String addPayCard = 'assets/payment/ic-addCard.svg';

  String pdfIcon = 'assets/report/pdf.svg';

  String engineIcon = 'assets/categories/engine.svg';
  String generalIcon = 'assets/categories/general_info.svg';
  String mechanicalBatteryIcon = 'assets/categories/mechanical_battery.svg';
  String mechanicalTransmissionIcon = 'assets/categories/transmission.svg';
  String interiorIcon = 'assets/categories/Interior.svg';
  String interiorSeatIcon = 'assets/categories/interior_seat.svg';
  String exteriorBodyIcon = 'assets/categories/exterior_body.svg';
  String exteriorDimensionIcon = 'assets/categories/exterior_dimension.svg';
  String exteriorWheelTireIcon = 'assets/categories/wheel.svg';
  String mechanicalBreakIcon = 'assets/categories/brake.svg';
  String airBagIcon = 'assets/categories/air_bag.svg';
  String activeSafetyIcon = 'assets/categories/active_safety.svg';
  String activeSafetySafeIcon =
      'assets/categories/active_safety_safe_distance.svg';
  String backingUpIcon = 'assets/categories/backing_up_parking.svg';
  String collisionIcon = 'assets/categories/collision_prevention.svg';
  String laneSideIcon = 'assets/categories/lane_side_assist.svg';
  String lightingIcon = 'assets/categories/lighting_technology.svg';
  String notifIcon = 'assets/categories/notif_911.svg';
  String passiveSafetyIcon = 'assets/categories/passive_safety_system.svg';
}
