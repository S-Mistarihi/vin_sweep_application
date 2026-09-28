import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/FAB/enter-vin/view/enter_vin_view.dart';
import 'package:vin_sweep_application/features/home/FAB/controller/fab_controller.dart';
import 'package:vin_sweep_application/features/home/FAB/fab_menu_view.dart';
import 'package:vin_sweep_application/features/home/FAB/model/fab_model.dart';
import 'package:vin_sweep_application/features/home/tabs/home/view/home_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/menu_view.dart';

class CustomPersistentBottomNavBar extends StatelessWidget {
  CustomPersistentBottomNavBar({super.key});

  final FabController controller = Get.put(FabController());

  List<FabModel> get _fabActions => [
    FabModel(assetPath: AppAssets().uploadFab, onTap: () {}),
    FabModel(assetPath: AppAssets().scanFab, onTap: () {}),
    FabModel(
      assetPath: AppAssets().enterFab,
      onTap: () {
        Get.to(() => EnterVinView(), transition: Transition.downToUp);
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: ValueListenableBuilder<bool>(
        valueListenable: controller.speedDialNotifier,
        builder: (context, isOpen, _) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              PersistentTabView(
                context,
                navBarHeight: 86,
                navBarStyle: NavBarStyle.style8,
                isVisible: !isOpen,
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
                screens: [HomeView(), MenuView()],
                items: [
                  PersistentBottomNavBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Transform.scale(
                        scale: .8,
                        child: SvgPicture.asset(AppAssets().homeIcon),
                      ),
                    ),
                    title: 'Home',
                    activeColorPrimary: AppColors().baseColor,
                    inactiveColorPrimary: AppColors().baseColor.withOpacity(
                      0.8,
                    ),
                  ),
                  PersistentBottomNavBarItem(
                    icon: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Transform.scale(
                        scale: 2.2,
                        child: SvgPicture.asset(AppAssets().menuIcon),
                      ),
                    ),
                    title: 'Menu',
                    activeColorPrimary: AppColors().baseColor,
                    inactiveColorPrimary: AppColors().baseColor.withOpacity(
                      0.8,
                    ),
                  ),
                ],
                popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
                stateManagement: true,
                hideNavigationBarWhenKeyboardAppears: true,
                resizeToAvoidBottomInset: true,
                handleAndroidBackButtonPress: true,
                confineToSafeArea: true,
              ),

              FabMenuView(
                actions: _fabActions,
                mainClosedAsset: AppAssets().scanQrCodeWithAnimation,
                mainOpenAsset: AppAssets().closeScanQrCodeAction,
                openMainButtonBackgroundColor: Colors.transparent,
              ),
            ],
          );
        },
      ),
    );
  }
}
