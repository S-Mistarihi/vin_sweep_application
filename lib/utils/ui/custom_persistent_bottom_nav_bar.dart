import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/screens/home/view/home_api.dart';
import 'package:vin_sweep_application/screens/home/view/menu_api.dart';

class CustomPersistentBottomNavBar extends StatelessWidget {

  const CustomPersistentBottomNavBar({super.key, });

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      bottom: false,
      child: Stack(
        children: [
          PersistentTabView(
            context,
            navBarHeight: 86,
            navBarStyle: NavBarStyle.style8,
            decoration: NavBarDecoration(
              colorBehindNavBar: AppColors().baseColor,
              useBackdropFilter: false,
              gradient: LinearGradient(
                colors: [
                  AppColors().firstPersistantBottomNavBarColor,
                  AppColors().secondPersistantBottomNavBarColor,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            animationSettings: NavBarAnimationSettings(
              navBarItemAnimation: ItemAnimationSettings(
                curve: Curves.ease,
                duration: Duration(microseconds: 200),
              ),
            ),
            screens: [HomeApi(), MenuApi()],
            items: [
              PersistentBottomNavBarItem(
                icon: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(Icons.home_outlined),
                ),
                title: 'Home',
                activeColorPrimary: AppColors().baseColor,
                inactiveColorPrimary: AppColors().baseColor.withOpacity(0.8),
              ),
              PersistentBottomNavBarItem(
                icon: Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(Icons.more_vert),
                ),
                title: 'Menu',
                activeColorPrimary: AppColors().baseColor,
                inactiveColorPrimary: AppColors().baseColor.withOpacity(0.8),
              ),
            ],
            popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
            stateManagement: true,
            hideNavigationBarWhenKeyboardAppears: true,
            resizeToAvoidBottomInset: true,
            handleAndroidBackButtonPress: true,
            confineToSafeArea: true,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 5,
            //bottom: -30,
            child: SvgPicture.asset(AppAssets().scanQrCodeAction, width: 160),
          ),
        ],
      ),
    );
  }
}
