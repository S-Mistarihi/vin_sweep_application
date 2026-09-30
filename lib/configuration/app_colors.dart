import 'package:flutter/material.dart';

class AppColors {
  AppColors._private();

  static final AppColors _shared = AppColors._private();

  factory AppColors() => _shared;

  Color baseColor = const Color(0xffFFFFFF);
  Color accentColor = const Color(0xff000000);

  Color firstHeaderShadowColor = const Color(0xff0A2342);
  Color secondHeaderShadowColor = const Color(0xff728CAA);

  Color buttonWithoutBackground = const Color(0xffFFFFFF);
  Color buttonWithoutBackgroundText = const Color(0xff1D416F);
  Color buttonWithBackground = const Color(0xff1D416F);
  Color buttonWithBackgroundText = const Color(0xffFFFFFF);

  Color mainIntroText = const Color(0xff000000);
  Color subIntroText = const Color(0xff919191);
  Color activePageIndicator = const Color(0xff1D416F);
  Color inactivePageIndicator = const Color(0xffA8C8DC);

  Color switcherBackgroundColor = const Color(0xffF2F6F8);
  Color textFieldBackgroundColor = const Color(0xffF8FAFC);
  Color textFieldBorderColor = const Color(0xffF2F6F8);
  Color textFieldLabelColor = const Color(0xff959595);
  Color errorText = const Color(0xffB31E3C);
  Color smallTextColor = const Color(0xff0093FF);
  Color rememberTextColor = const Color(0xff9F9F9F);
  Color rememberBorderColor = const Color(0xff959595);
  Color rememberCheckedColor = const Color(0xffFFFFFF);

  Color resendTextColor = const Color(0xff0F8AD8);

  Color errorDialogColor = const Color(0xffDB1845);
  Color successDialogColor = const Color(0xff3DC179);
  Color closeIconDialogBackgroundColor = const Color(0xff1D416F);
  Color closeIconDialogColor = const Color(0xffEBF5FA);

  Color firstPersistantBottomNavBarColor = const Color(0xff1D416F);
  Color secondPersistantBottomNavBarColor = const Color(0xff0F2138);

  Color menuDividerColor = const Color(0xffD0E1EA);
  Color logoutButton = const Color(0xffCE2829);

  Color cardPlanShadow = const Color(0xffC4C4C4);
  Color mainColorWithNoScans = const Color(0xff1D416F);

  Color cardPlanBorder = const Color(0xffE2E7F5);
  Color cardPlanText = const Color(0xff1D416F);
  Color cardPlanCheck = const Color(0xff40A204);
  Color inactiveTrackSwitchColor = const Color(0xffF2F2F2);
  Color cardPopularBack = const Color(0xffBA68C8);

  Color generalInfoContainerBackground = const Color(0xffEBF5FA);
  Color generalInfoContainerBorder = const Color(0xffA8C8DC);
  Color scanningLine = const Color(0xffEB2A2A);
}
