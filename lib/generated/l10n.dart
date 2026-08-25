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

  /// `One time pin is required`
  String get oneTimePinIsRequired {
    return Intl.message(
      'One time pin is required',
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
