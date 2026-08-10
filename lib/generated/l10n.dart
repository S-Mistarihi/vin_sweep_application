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
