// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `the sys config data is missing`
  String get theSysConfigDataIsMissing {
    return Intl.message(
      'the sys config data is missing',
      name: 'theSysConfigDataIsMissing',
      desc: '',
      args: [],
    );
  }

  /// `Failed to parse sys config response`
  String get failedToParseSysConfigResponse {
    return Intl.message(
      'Failed to parse sys config response',
      name: 'failedToParseSysConfigResponse',
      desc: '',
      args: [],
    );
  }

  /// `the sys config response dows not match the expected model`
  String get theSysConfigResponseDowsNotMatchTheExpectedModel {
    return Intl.message(
      'the sys config response dows not match the expected model',
      name: 'theSysConfigResponseDowsNotMatchTheExpectedModel',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skipButton {
    return Intl.message('Skip', name: 'skipButton', desc: '', args: []);
  }

  /// `Easily Scan Any Vehicle Type for Details`
  String get titleIntro1 {
    return Intl.message(
      'Easily Scan Any Vehicle Type for Details',
      name: 'titleIntro1',
      desc: '',
      args: [],
    );
  }

  /// `Supports sedans, hatchbacks, trucks, and more. Get information on any vehicle type easily.`
  String get descriptionIntro1 {
    return Intl.message(
      'Supports sedans, hatchbacks, trucks, and more. Get information on any vehicle type easily.',
      name: 'descriptionIntro1',
      desc: '',
      args: [],
    );
  }

  /// `Enter VIN by Camera, Image, or Manually`
  String get titleIntro2 {
    return Intl.message(
      'Enter VIN by Camera, Image, or Manually',
      name: 'titleIntro2',
      desc: '',
      args: [],
    );
  }

  /// `Quickly get information about any vehicle by entering the VIN manually, scanning an image, or tacking a photo.`
  String get descriptionIntro2 {
    return Intl.message(
      'Quickly get information about any vehicle by entering the VIN manually, scanning an image, or tacking a photo.',
      name: 'descriptionIntro2',
      desc: '',
      args: [],
    );
  }

  /// `Get Detailed and Accurate Vehicle Information`
  String get titleIntro3 {
    return Intl.message(
      'Get Detailed and Accurate Vehicle Information',
      name: 'titleIntro3',
      desc: '',
      args: [],
    );
  }

  /// `Retrieve comprehensive details about any vehicle, including make, models, year, and specifications.`
  String get descriptionIntro3 {
    return Intl.message(
      'Retrieve comprehensive details about any vehicle, including make, models, year, and specifications.',
      name: 'descriptionIntro3',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get backButton {
    return Intl.message('Back', name: 'backButton', desc: '', args: []);
  }

  /// `Next`
  String get nextButton {
    return Intl.message('Next', name: 'nextButton', desc: '', args: []);
  }

  /// `Get Started`
  String get getStartedButton {
    return Intl.message(
      'Get Started',
      name: 'getStartedButton',
      desc: '',
      args: [],
    );
  }

  /// `the server returned an invalid format`
  String get theServerReturnedAnInvalidFormat {
    return Intl.message(
      'the server returned an invalid format',
      name: 'theServerReturnedAnInvalidFormat',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to the server , please check your internet exception`
  String get unableToConnectToTheServerPleaseCheckYourInternet {
    return Intl.message(
      'Unable to connect to the server , please check your internet exception',
      name: 'unableToConnectToTheServerPleaseCheckYourInternet',
      desc: '',
      args: [],
    );
  }

  /// `the request timed out please try again later`
  String get theRequestTimedOutPleaseTryAgainLater {
    return Intl.message(
      'the request timed out please try again later',
      name: 'theRequestTimedOutPleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `an unexpected error occured , please try again`
  String get anUnexpectedErrorOccuredPleaseTryAgain {
    return Intl.message(
      'an unexpected error occured , please try again',
      name: 'anUnexpectedErrorOccuredPleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Invalid request sent to the server.`
  String get invalidRequestSentToTheServer {
    return Intl.message(
      'Invalid request sent to the server.',
      name: 'invalidRequestSentToTheServer',
      desc: '',
      args: [],
    );
  }

  /// `you are not authorized to access this data`
  String get youAreNotAuthorizedToAccessThisData {
    return Intl.message(
      'you are not authorized to access this data',
      name: 'youAreNotAuthorizedToAccessThisData',
      desc: '',
      args: [],
    );
  }

  /// `sys config endpoint was not found`
  String get sysConfigEndpointWasNotFound {
    return Intl.message(
      'sys config endpoint was not found',
      name: 'sysConfigEndpointWasNotFound',
      desc: '',
      args: [],
    );
  }

  /// `the server returned an unsuccessful response`
  String get theServerReturnedAnUnsuccessfulResponse {
    return Intl.message(
      'the server returned an unsuccessful response',
      name: 'theServerReturnedAnUnsuccessfulResponse',
      desc: '',
      args: [],
    );
  }

  /// `Please fill your email`
  String get pleaseFillYourEmail {
    return Intl.message(
      'Please fill your email',
      name: 'pleaseFillYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please fill your password`
  String get pleaseFillYourPassword {
    return Intl.message(
      'Please fill your password',
      name: 'pleaseFillYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please fill your full name`
  String get pleaseFillYourName {
    return Intl.message(
      'Please fill your full name',
      name: 'pleaseFillYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a correct name`
  String get pleaseEnterCorrectName {
    return Intl.message(
      'Please enter a correct name',
      name: 'pleaseEnterCorrectName',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMustBeAtLeast6Character {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMustBeAtLeast6Character',
      desc: '',
      args: [],
    );
  }

  /// `Please fill your ZIP code`
  String get pleaseFillYourCountryZipcode {
    return Intl.message(
      'Please fill your ZIP code',
      name: 'pleaseFillYourCountryZipcode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a correct ZIP code`
  String get pleaseFillCorrectZipcode {
    return Intl.message(
      'Please enter a correct ZIP code',
      name: 'pleaseFillCorrectZipcode',
      desc: '',
      args: [],
    );
  }

  /// `You created an account successfully`
  String get youCreatedAnAccountSuccessfully {
    return Intl.message(
      'You created an account successfully',
      name: 'youCreatedAnAccountSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginHeaderMainText {
    return Intl.message(
      'Login',
      name: 'loginHeaderMainText',
      desc: '',
      args: [],
    );
  }

  /// `Create your Account`
  String get registerHeaderMainText {
    return Intl.message(
      'Create your Account',
      name: 'registerHeaderMainText',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your credentials below`
  String get loginHeaderSubText {
    return Intl.message(
      'Please enter your credentials below',
      name: 'loginHeaderSubText',
      desc: '',
      args: [],
    );
  }

  /// `Please fill your information below`
  String get registerHeaderSubText {
    return Intl.message(
      'Please fill your information below',
      name: 'registerHeaderSubText',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get loginSwitcher {
    return Intl.message('Sign In', name: 'loginSwitcher', desc: '', args: []);
  }

  /// `Register`
  String get registerButton {
    return Intl.message('Register', name: 'registerButton', desc: '', args: []);
  }

  /// `Remember me!`
  String get rememberMeCheckbox {
    return Intl.message(
      'Remember me!',
      name: 'rememberMeCheckbox',
      desc: '',
      args: [],
    );
  }

  /// `Fogot Password`
  String get fogotPasswordButton {
    return Intl.message(
      'Fogot Password',
      name: 'fogotPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButton {
    return Intl.message('Login', name: 'loginButton', desc: '', args: []);
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Name`
  String get nameLabel {
    return Intl.message('Name', name: 'nameLabel', desc: '', args: []);
  }

  /// `Zip Code`
  String get zipCodeLabel {
    return Intl.message('Zip Code', name: 'zipCodeLabel', desc: '', args: []);
  }

  /// `Enter OTP`
  String get otpHeaderMainText {
    return Intl.message(
      'Enter OTP',
      name: 'otpHeaderMainText',
      desc: '',
      args: [],
    );
  }

  /// `Enter the OTP code sent to the registered email address.`
  String get otpHeaderSubText {
    return Intl.message(
      'Enter the OTP code sent to the registered email address.',
      name: 'otpHeaderSubText',
      desc: '',
      args: [],
    );
  }

  /// `OTP pin is required`
  String get oneTimePinIsRequired {
    return Intl.message(
      'OTP pin is required',
      name: 'oneTimePinIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `OTP resent successfully`
  String get otpResentSuccessfully {
    return Intl.message(
      'OTP resent successfully',
      name: 'otpResentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `OTP Code`
  String get otpCodeLabel {
    return Intl.message('OTP Code', name: 'otpCodeLabel', desc: '', args: []);
  }

  /// `Submit`
  String get submitOtpButton {
    return Intl.message('Submit', name: 'submitOtpButton', desc: '', args: []);
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Invalid OTP Value`
  String get errorTitleDialog {
    return Intl.message(
      'Invalid OTP Value',
      name: 'errorTitleDialog',
      desc: '',
      args: [],
    );
  }

  /// `Please Re-enter the OTP value received again`
  String get errorDescriptionDialog {
    return Intl.message(
      'Please Re-enter the OTP value received again',
      name: 'errorDescriptionDialog',
      desc: '',
      args: [],
    );
  }

  /// `OTP verified successfully`
  String get successTitleDialog {
    return Intl.message(
      'OTP verified successfully',
      name: 'successTitleDialog',
      desc: '',
      args: [],
    );
  }

  /// `You created an account successfully.`
  String get successDescriptionDialog {
    return Intl.message(
      'You created an account successfully.',
      name: 'successDescriptionDialog',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message('Menu', name: 'menu', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `My Plans`
  String get myPlans {
    return Intl.message('My Plans', name: 'myPlans', desc: '', args: []);
  }

  /// `Payments Info`
  String get paymentsInfo {
    return Intl.message(
      'Payments Info',
      name: 'paymentsInfo',
      desc: '',
      args: [],
    );
  }

  /// `Scans History`
  String get scansHistory {
    return Intl.message(
      'Scans History',
      name: 'scansHistory',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactUs {
    return Intl.message('Contact Us', name: 'contactUs', desc: '', args: []);
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Refund Policy`
  String get refundPolicy {
    return Intl.message(
      'Refund Policy',
      name: 'refundPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsConditions',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutButton {
    return Intl.message('Logout', name: 'logoutButton', desc: '', args: []);
  }

  /// `Password and confirm password do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Password and confirm password do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `New password must be different from the current password`
  String get newPasswordMustBeDifferent {
    return Intl.message(
      'New password must be different from the current password',
      name: 'newPasswordMustBeDifferent',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Email`
  String get confirmEmailLabel {
    return Intl.message(
      'Confirm Email',
      name: 'confirmEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'newPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password does not match`
  String get confirmPasswordDoesNotMatch {
    return Intl.message(
      'Confirm password does not match',
      name: 'confirmPasswordDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Your password reset successfull`
  String get yourPasswordResetSuccessfull {
    return Intl.message(
      'Your password reset successfull',
      name: 'yourPasswordResetSuccessfull',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneLabel {
    return Intl.message('Phone', name: 'phoneLabel', desc: '', args: []);
  }

  /// `Please enter VIN number`
  String get pleaseEnterVinNumber {
    return Intl.message(
      'Please enter VIN number',
      name: 'pleaseEnterVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `VIN must contain 17 characters`
  String get vinMustContain17Characters {
    return Intl.message(
      'VIN must contain 17 characters',
      name: 'vinMustContain17Characters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid VIN number`
  String get pleaseEnterAValidVinNumber {
    return Intl.message(
      'Please enter a valid VIN number',
      name: 'pleaseEnterAValidVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `VIN Number`
  String get vinNumberLabel {
    return Intl.message(
      'VIN Number',
      name: 'vinNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get searchLabel {
    return Intl.message('Search', name: 'searchLabel', desc: '', args: []);
  }

  /// `Warning`
  String get warning {
    return Intl.message('Warning', name: 'warning', desc: '', args: []);
  }

  /// `General Info`
  String get generalInfoSwitcher {
    return Intl.message(
      'General Info',
      name: 'generalInfoSwitcher',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reportsSwitcher {
    return Intl.message('Reports', name: 'reportsSwitcher', desc: '', args: []);
  }

  /// `Buy Report`
  String get buyReportButton {
    return Intl.message(
      'Buy Report',
      name: 'buyReportButton',
      desc: '',
      args: [],
    );
  }

  /// `Searching for Info`
  String get searchingForInfo {
    return Intl.message(
      'Searching for Info',
      name: 'searchingForInfo',
      desc: '',
      args: [],
    );
  }

  /// `This section includes free data like make, model, engine type, and body style.`
  String get thisSectionIncludesFreeDataLikeMakeModelEngineType {
    return Intl.message(
      'This section includes free data like make, model, engine type, and body style.',
      name: 'thisSectionIncludesFreeDataLikeMakeModelEngineType',
      desc: '',
      args: [],
    );
  }

  /// `˄ Collapse`
  String get collapse {
    return Intl.message('˄ Collapse', name: 'collapse', desc: '', args: []);
  }

  /// `˅ Expanded`
  String get expanded {
    return Intl.message('˅ Expanded', name: 'expanded', desc: '', args: []);
  }

  /// `Information not available for this detail`
  String get informationNotAvailableForThisDetail {
    return Intl.message(
      'Information not available for this detail',
      name: 'informationNotAvailableForThisDetail',
      desc: '',
      args: [],
    );
  }

  /// `Scan Vehicle VIN Number`
  String get scanVehicleVinNumber {
    return Intl.message(
      'Scan Vehicle VIN Number',
      name: 'scanVehicleVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Scan your vehicle VIN number through the camera`
  String get scanYourVehicleVinNumberThroughTheCamera {
    return Intl.message(
      'Scan your vehicle VIN number through the camera',
      name: 'scanYourVehicleVinNumberThroughTheCamera',
      desc: '',
      args: [],
    );
  }

  /// `Scanned VIN Number`
  String get scannedVinNumberLabel {
    return Intl.message(
      'Scanned VIN Number',
      name: 'scannedVinNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Re-Scan`
  String get rescanButton {
    return Intl.message('Re-Scan', name: 'rescanButton', desc: '', args: []);
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Scan the VIN number of your car`
  String get scanTheVinNumberOfYourCar {
    return Intl.message(
      'Scan the VIN number of your car',
      name: 'scanTheVinNumberOfYourCar',
      desc: '',
      args: [],
    );
  }

  /// `VIN detected ✓`
  String get vinDetected {
    return Intl.message(
      'VIN detected ✓',
      name: 'vinDetected',
      desc: '',
      args: [],
    );
  }

  /// `Scanning...`
  String get scanning {
    return Intl.message('Scanning...', name: 'scanning', desc: '', args: []);
  }

  /// `No camera was found.`
  String get noCameraWasFound {
    return Intl.message(
      'No camera was found.',
      name: 'noCameraWasFound',
      desc: '',
      args: [],
    );
  }

  /// `Camera permission denied. Please enable it from Settings.`
  String get cameraPermissionDeniedPleaseEnableItFromSettings {
    return Intl.message(
      'Camera permission denied. Please enable it from Settings.',
      name: 'cameraPermissionDeniedPleaseEnableItFromSettings',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while opening the camera.`
  String get somethingWentWrongWhileOpeningTheCamera {
    return Intl.message(
      'Something went wrong while opening the camera.',
      name: 'somethingWentWrongWhileOpeningTheCamera',
      desc: '',
      args: [],
    );
  }

  /// `Unable to initialize camera.`
  String get unableToInitializeCamera {
    return Intl.message(
      'Unable to initialize camera.',
      name: 'unableToInitializeCamera',
      desc: '',
      args: [],
    );
  }

  /// `VIN must be exactly 17 characters.`
  String get vinMustBeExactly17Characters {
    return Intl.message(
      'VIN must be exactly 17 characters.',
      name: 'vinMustBeExactly17Characters',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retryButton {
    return Intl.message('Retry', name: 'retryButton', desc: '', args: []);
  }

  /// `No payment methods`
  String get noPaymentMethods {
    return Intl.message(
      'No payment methods',
      name: 'noPaymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get defaultLabel {
    return Intl.message('Default', name: 'defaultLabel', desc: '', args: []);
  }

  /// `Delete Payment Method`
  String get deletePaymentMethod {
    return Intl.message(
      'Delete Payment Method',
      name: 'deletePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message('Cancel', name: 'cancelButton', desc: '', args: []);
  }

  /// `Delete`
  String get deleteButton {
    return Intl.message('Delete', name: 'deleteButton', desc: '', args: []);
  }

  /// `More Actions`
  String get moreActions {
    return Intl.message(
      'More Actions',
      name: 'moreActions',
      desc: '',
      args: [],
    );
  }

  /// `Make Default`
  String get makeDefault {
    return Intl.message(
      'Make Default',
      name: 'makeDefault',
      desc: '',
      args: [],
    );
  }

  /// `No payment history`
  String get noPaymentHistory {
    return Intl.message(
      'No payment history',
      name: 'noPaymentHistory',
      desc: '',
      args: [],
    );
  }

  /// `My Plans`
  String get myPlansTitle {
    return Intl.message('My Plans', name: 'myPlansTitle', desc: '', args: []);
  }

  /// `No plans available`
  String get noPlansAvailable {
    return Intl.message(
      'No plans available',
      name: 'noPlansAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Plan`
  String get cancelPlanButton {
    return Intl.message(
      'Cancel Plan',
      name: 'cancelPlanButton',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade`
  String get upgradeButton {
    return Intl.message('Upgrade', name: 'upgradeButton', desc: '', args: []);
  }

  /// `Auto Renwe`
  String get autoRenweSwitch {
    return Intl.message(
      'Auto Renwe',
      name: 'autoRenweSwitch',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get mostPopularPart {
    return Intl.message(
      'Most Popular',
      name: 'mostPopularPart',
      desc: '',
      args: [],
    );
  }

  /// `Plan`
  String get planCardLabel {
    return Intl.message('Plan', name: 'planCardLabel', desc: '', args: []);
  }

  /// `Reports`
  String get reportsCardLabel {
    return Intl.message(
      'Reports',
      name: 'reportsCardLabel',
      desc: '',
      args: [],
    );
  }

  /// `Add Card`
  String get addCardButton {
    return Intl.message('Add Card', name: 'addCardButton', desc: '', args: []);
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Review & Confirmation`
  String get reviewConfirmation {
    return Intl.message(
      'Review & Confirmation',
      name: 'reviewConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Accept terms and conditions`
  String get acceptTermsAndConditions {
    return Intl.message(
      'Accept terms and conditions',
      name: 'acceptTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmButton {
    return Intl.message('Confirm', name: 'confirmButton', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Welcome {firstName},`
  String welcome(String firstName) {
    return Intl.message(
      'Welcome $firstName,',
      name: 'welcome',
      desc: '',
      args: [firstName],
    );
  }

  /// `Last Login: {date}`
  String lastLogin(String date) {
    return Intl.message(
      'Last Login: $date',
      name: 'lastLogin',
      desc: '',
      args: [date],
    );
  }

  /// `Total Sweeps`
  String get totalSweeps {
    return Intl.message(
      'Total Sweeps',
      name: 'totalSweeps',
      desc: '',
      args: [],
    );
  }

  /// `Latest Scans`
  String get latestScans {
    return Intl.message(
      'Latest Scans',
      name: 'latestScans',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message('See All', name: 'seeAll', desc: '', args: []);
  }

  /// `No Scans Yet`
  String get noScansYet {
    return Intl.message('No Scans Yet', name: 'noScansYet', desc: '', args: []);
  }

  /// `The list is currently empty`
  String get theListIsCurrentlyEmpty {
    return Intl.message(
      'The list is currently empty',
      name: 'theListIsCurrentlyEmpty',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResultsFound {
    return Intl.message(
      'No results found',
      name: 'noResultsFound',
      desc: '',
      args: [],
    );
  }

  /// `Couldn't load your plan`
  String get couldntLoadYourPlan {
    return Intl.message(
      'Couldn\'t load your plan',
      name: 'couldntLoadYourPlan',
      desc: '',
      args: [],
    );
  }

  /// `No active plan`
  String get noActivePlan {
    return Intl.message(
      'No active plan',
      name: 'noActivePlan',
      desc: '',
      args: [],
    );
  }

  /// `Choose a plan to start generating reports`
  String get chooseAPlanToStartGeneratingReports {
    return Intl.message(
      'Choose a plan to start generating reports',
      name: 'chooseAPlanToStartGeneratingReports',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Plan`
  String get chooseAPlan {
    return Intl.message(
      'Choose a Plan',
      name: 'chooseAPlan',
      desc: '',
      args: [],
    );
  }

  /// `Renew Plan`
  String get renewPlan {
    return Intl.message('Renew Plan', name: 'renewPlan', desc: '', args: []);
  }

  /// `Remaining`
  String get remaining {
    return Intl.message('Remaining', name: 'remaining', desc: '', args: []);
  }

  /// `Reports Bought`
  String get reportsBought {
    return Intl.message(
      'Reports Bought',
      name: 'reportsBought',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Expired`
  String get expired {
    return Intl.message('Expired', name: 'expired', desc: '', args: []);
  }

  /// `Learn more about VINSweep.`
  String get learnMoreAboutVinsweep {
    return Intl.message(
      'Learn more about VINSweep.',
      name: 'learnMoreAboutVinsweep',
      desc: '',
      args: [],
    );
  }

  /// `VINSweep`
  String get vinsweep {
    return Intl.message('VINSweep', name: 'vinsweep', desc: '', args: []);
  }

  /// `Please enter your current password and new password`
  String get pleaseEnterYourCurrentPasswordAndNewPassword {
    return Intl.message(
      'Please enter your current password and new password',
      name: 'pleaseEnterYourCurrentPasswordAndNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-Type New Password`
  String get retypeNewPassword {
    return Intl.message(
      'Re-Type New Password',
      name: 'retypeNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get changeButton {
    return Intl.message('Change', name: 'changeButton', desc: '', args: []);
  }

  /// `Please select the suitable way for you to reach us.`
  String get pleaseSelectTheSuitableWayForYouToReachUs {
    return Intl.message(
      'Please select the suitable way for you to reach us.',
      name: 'pleaseSelectTheSuitableWayForYouToReachUs',
      desc: '',
      args: [],
    );
  }

  /// `Call Us`
  String get callUs {
    return Intl.message('Call Us', name: 'callUs', desc: '', args: []);
  }

  /// `Whatsapp`
  String get whatsapp {
    return Intl.message('Whatsapp', name: 'whatsapp', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Website`
  String get website {
    return Intl.message('Website', name: 'website', desc: '', args: []);
  }

  /// `Failed`
  String get failed {
    return Intl.message('Failed', name: 'failed', desc: '', args: []);
  }

  /// `Loading failed`
  String get loadingFailed {
    return Intl.message(
      'Loading failed',
      name: 'loadingFailed',
      desc: '',
      args: [],
    );
  }

  /// `This contact option is not available`
  String get thisContactOptionIsNotAvailable {
    return Intl.message(
      'This contact option is not available',
      name: 'thisContactOptionIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Invalid link`
  String get invalidLink {
    return Intl.message(
      'Invalid link',
      name: 'invalidLink',
      desc: '',
      args: [],
    );
  }

  /// `Could not open this link`
  String get couldNotOpenThisLink {
    return Intl.message(
      'Could not open this link',
      name: 'couldNotOpenThisLink',
      desc: '',
      args: [],
    );
  }

  /// `Phone number is not available`
  String get phoneNumberIsNotAvailable {
    return Intl.message(
      'Phone number is not available',
      name: 'phoneNumberIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Could not open phone`
  String get couldNotOpenPhone {
    return Intl.message(
      'Could not open phone',
      name: 'couldNotOpenPhone',
      desc: '',
      args: [],
    );
  }

  /// `Whatsapp is not available`
  String get whatsappIsNotAvailable {
    return Intl.message(
      'Whatsapp is not available',
      name: 'whatsappIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Email is not available`
  String get emailIsNotAvailable {
    return Intl.message(
      'Email is not available',
      name: 'emailIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Could not open email`
  String get couldNotOpenEmail {
    return Intl.message(
      'Could not open email',
      name: 'couldNotOpenEmail',
      desc: '',
      args: [],
    );
  }

  /// `Website is not available`
  String get websiteIsNotAvailable {
    return Intl.message(
      'Website is not available',
      name: 'websiteIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Instagram is not available`
  String get instagramIsNotAvailable {
    return Intl.message(
      'Instagram is not available',
      name: 'instagramIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `TikTok is not available`
  String get tiktokIsNotAvailable {
    return Intl.message(
      'TikTok is not available',
      name: 'tiktokIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Twitter is not available`
  String get twitterIsNotAvailable {
    return Intl.message(
      'Twitter is not available',
      name: 'twitterIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Facebook is not available`
  String get facebookIsNotAvailable {
    return Intl.message(
      'Facebook is not available',
      name: 'facebookIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `YouTube is not available`
  String get youtubeIsNotAvailable {
    return Intl.message(
      'YouTube is not available',
      name: 'youtubeIsNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Payment Methods`
  String get paymentMethods {
    return Intl.message(
      'Payment Methods',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Payment History`
  String get paymentHistory {
    return Intl.message(
      'Payment History',
      name: 'paymentHistory',
      desc: '',
      args: [],
    );
  }

  /// `Add Payment Method`
  String get addPaymentMethod {
    return Intl.message(
      'Add Payment Method',
      name: 'addPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the card {cardNumber}?`
  String confirmDeleteCard(String cardNumber) {
    return Intl.message(
      'Are you sure you want to delete the card $cardNumber?',
      name: 'confirmDeleteCard',
      desc: '',
      args: [cardNumber],
    );
  }

  /// `Deleting this card means it will be permanently removed and unavailable for future use`
  String get deleteCardDescription {
    return Intl.message(
      'Deleting this card means it will be permanently removed and unavailable for future use',
      name: 'deleteCardDescription',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yesButton {
    return Intl.message('Yes', name: 'yesButton', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Failed set/delete payment method`
  String get failedSetdeletePaymentMethod {
    return Intl.message(
      'Failed set/delete payment method',
      name: 'failedSetdeletePaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `View all Plans`
  String get viewAllPlans {
    return Intl.message(
      'View all Plans',
      name: 'viewAllPlans',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `All Plans`
  String get allPlans {
    return Intl.message('All Plans', name: 'allPlans', desc: '', args: []);
  }

  /// `Current Plan`
  String get currentPlan {
    return Intl.message(
      'Current Plan',
      name: 'currentPlan',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Upgrade`
  String get upgrade {
    return Intl.message('Upgrade', name: 'upgrade', desc: '', args: []);
  }

  /// `You can only edit your name and ZIP code`
  String get youCanOnlyEditYourNameAndZipCode {
    return Intl.message(
      'You can only edit your name and ZIP code',
      name: 'youCanOnlyEditYourNameAndZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your ZIP code`
  String get pleaseEnterYourZipCode {
    return Intl.message(
      'Please enter your ZIP code',
      name: 'pleaseEnterYourZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid ZIP code`
  String get pleaseEnterAValidZipCode {
    return Intl.message(
      'Please enter a valid ZIP code',
      name: 'pleaseEnterAValidZipCode',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccessfully {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `With reports only`
  String get withReportsOnly {
    return Intl.message(
      'With reports only',
      name: 'withReportsOnly',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message('Sort by', name: 'sortBy', desc: '', args: []);
  }

  /// `Period`
  String get period {
    return Intl.message('Period', name: 'period', desc: '', args: []);
  }

  /// `Enter Vehicle VIN Number`
  String get enterVehicleVinNumber {
    return Intl.message(
      'Enter Vehicle VIN Number',
      name: 'enterVehicleVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter the vehicle VIN number, it is a serial number and contains 17 character alphanumeric`
  String get enterTheVehicleVinNumberItIsASerialNumber {
    return Intl.message(
      'Enter the vehicle VIN number, it is a serial number and contains 17 character alphanumeric',
      name: 'enterTheVehicleVinNumberItIsASerialNumber',
      desc: '',
      args: [],
    );
  }

  /// `Bought reports include accident history, mileage records, previous ownership, and more.`
  String
  get boughtReportsIncludeAccidentHistoryMileageRecordsPreviousOwnershipAnd {
    return Intl.message(
      'Bought reports include accident history, mileage records, previous ownership, and more.',
      name:
          'boughtReportsIncludeAccidentHistoryMileageRecordsPreviousOwnershipAnd',
      desc: '',
      args: [],
    );
  }

  /// `No reports yet for this vehicle`
  String get noReportsYetForThisVehicle {
    return Intl.message(
      'No reports yet for this vehicle',
      name: 'noReportsYetForThisVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Reports include accident history, mileage verification, previous owners, and more.`
  String
  get reportsIncludeAccidentHistoryMileageVerificationPreviousOwnersAndMore {
    return Intl.message(
      'Reports include accident history, mileage verification, previous owners, and more.',
      name:
          'reportsIncludeAccidentHistoryMileageVerificationPreviousOwnersAndMore',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Report`
  String get vehicleReport {
    return Intl.message(
      'Vehicle Report',
      name: 'vehicleReport',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect vin number`
  String get incorrectVinNumber {
    return Intl.message(
      'Incorrect vin number',
      name: 'incorrectVinNumber',
      desc: '',
      args: [],
    );
  }

  /// `Discount Coupon`
  String get discountCoupon {
    return Intl.message(
      'Discount Coupon',
      name: 'discountCoupon',
      desc: '',
      args: [],
    );
  }

  /// `Enter coupon code`
  String get enterCouponCode {
    return Intl.message(
      'Enter coupon code',
      name: 'enterCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Original price`
  String get originalPrice {
    return Intl.message(
      'Original price',
      name: 'originalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discount {
    return Intl.message('Discount', name: 'discount', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Invalid coupon code`
  String get invalidCouponCode {
    return Intl.message(
      'Invalid coupon code',
      name: 'invalidCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Add Card`
  String get addCard {
    return Intl.message('Add Card', name: 'addCard', desc: '', args: []);
  }

  /// `Add Card information`
  String get addCardInformation {
    return Intl.message(
      'Add Card information',
      name: 'addCardInformation',
      desc: '',
      args: [],
    );
  }

  /// `Card Info`
  String get cardInfo {
    return Intl.message('Card Info', name: 'cardInfo', desc: '', args: []);
  }

  /// `Save card`
  String get saveCard {
    return Intl.message('Save card', name: 'saveCard', desc: '', args: []);
  }

  /// `Card error`
  String get cardError {
    return Intl.message('Card error', name: 'cardError', desc: '', args: []);
  }

  /// `Please select a card`
  String get pleaseSelectACard {
    return Intl.message(
      'Please select a card',
      name: 'pleaseSelectACard',
      desc: '',
      args: [],
    );
  }

  /// `Terms`
  String get terms {
    return Intl.message('Terms', name: 'terms', desc: '', args: []);
  }

  /// `Please accept the terms and conditions`
  String get pleaseAcceptTheTermsAndConditions {
    return Intl.message(
      'Please accept the terms and conditions',
      name: 'pleaseAcceptTheTermsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Payment failed`
  String get paymentFailed {
    return Intl.message(
      'Payment failed',
      name: 'paymentFailed',
      desc: '',
      args: [],
    );
  }

  /// `Subscription successful`
  String get subscriptionSuccessful {
    return Intl.message(
      'Subscription successful',
      name: 'subscriptionSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Payment was not completed`
  String get paymentWasNotCompleted {
    return Intl.message(
      'Payment was not completed',
      name: 'paymentWasNotCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Reports History`
  String get reportsHistory {
    return Intl.message(
      'Reports History',
      name: 'reportsHistory',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle`
  String get vehicle {
    return Intl.message('Vehicle', name: 'vehicle', desc: '', args: []);
  }

  /// `VIN`
  String get vin {
    return Intl.message('VIN', name: 'vin', desc: '', args: []);
  }

  /// `No reports yet`
  String get noReportsYet {
    return Intl.message(
      'No reports yet',
      name: 'noReportsYet',
      desc: '',
      args: [],
    );
  }

  /// `Reports you buy will appear here`
  String get reportsYouBuyWillAppearHere {
    return Intl.message(
      'Reports you buy will appear here',
      name: 'reportsYouBuyWillAppearHere',
      desc: '',
      args: [],
    );
  }

  /// `Report link is not available yet`
  String get reportLinkIsNotAvailableYet {
    return Intl.message(
      'Report link is not available yet',
      name: 'reportLinkIsNotAvailableYet',
      desc: '',
      args: [],
    );
  }

  /// `Invalid report link`
  String get invalidReportLink {
    return Intl.message(
      'Invalid report link',
      name: 'invalidReportLink',
      desc: '',
      args: [],
    );
  }

  /// `The downloaded file is not a valid PDF`
  String get theDownloadedFileIsNotAValidPdf {
    return Intl.message(
      'The downloaded file is not a valid PDF',
      name: 'theDownloadedFileIsNotAValidPdf',
      desc: '',
      args: [],
    );
  }

  /// `No app found to open PDF files`
  String get noAppFoundToOpenPdfFiles {
    return Intl.message(
      'No app found to open PDF files',
      name: 'noAppFoundToOpenPdfFiles',
      desc: '',
      args: [],
    );
  }

  /// `Could not open the report`
  String get couldNotOpenTheReport {
    return Intl.message(
      'Could not open the report',
      name: 'couldNotOpenTheReport',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message('Report', name: 'report', desc: '', args: []);
  }

  /// `Purchase failed`
  String get purchaseFailed {
    return Intl.message(
      'Purchase failed',
      name: 'purchaseFailed',
      desc: '',
      args: [],
    );
  }

  /// `Report purchased`
  String get reportPurchased {
    return Intl.message(
      'Report purchased',
      name: 'reportPurchased',
      desc: '',
      args: [],
    );
  }

  /// `Your vehicle report is ready.`
  String get yourVehicleReportIsReady {
    return Intl.message(
      'Your vehicle report is ready.',
      name: 'yourVehicleReportIsReady',
      desc: '',
      args: [],
    );
  }

  /// `Invalid payment intent`
  String get invalidPaymentIntent {
    return Intl.message(
      'Invalid payment intent',
      name: 'invalidPaymentIntent',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
