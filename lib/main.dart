import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/generated/l10n.dart';
import 'package:vin_sweep_application/l10n/app_locale.dart';
import 'package:vin_sweep_application/screens/intro/view/intro_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  Locale deviceLocale = widgetsBinding.platformDispatcher.locale;
  String defaultLanguageCode = deviceLocale.languageCode;

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  Get.put<SharedPreferences>(prefs);

  String savedLanguageCode =
      prefs.getString('currentLanguage') ?? defaultLanguageCode;

  AppLocale().changeLanguage(languageCode: savedLanguageCode);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return ScopedModel<AppLocale>(
          model: AppLocale(),
          child: ScopedModelDescendant<AppLocale>(
            builder: (_, w, appLocale) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: IntroScreen(),
                locale: AppLocale().locale,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                theme: ThemeData(fontFamily: 'Open Sans'),
              );
            },
          ),
        );
      },
    );
  }
}
