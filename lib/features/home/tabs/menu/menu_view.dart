import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/about/controller/about_us_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/about/view/about_us_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/change_password/view/change_password_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/contact_us/controller/contact_info_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/contact_us/view/contact_us_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/payment/payment_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/plans/plans_navigator.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/profile/controller/profile_controller.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/profile/view/profile_view.dart';
import 'package:vin_sweep_application/features/home/tabs/menu/scan_history/view/scan_history_view.dart';
import 'package:vin_sweep_application/utils/helpers/logout_session_helper.dart';

import '../../../../generated/l10n.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().baseColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 5.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                S.of(context).menu,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            _buildMenuItem(
              context: context,
              icon: AppAssets().profileIcon,
              name: S.of(context).profile,
              onTap: () {
                Get.put(ProfileController());
                Get.to(ProfileView(), transition: Transition.rightToLeft);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().plansIcon,
              name: S.of(context).myPlans,
              onTap: PlansNavigator.openMyPlans,
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().paymentIcon,
              name: S.of(context).paymentsInfo,
              onTap: () =>
                  Get.to(PaymentView(), transition: Transition.rightToLeft),
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().scanHistoryIcon,
              name: S.of(context).scansHistory,
              onTap: () =>
                  Get.to(ScanHistoryView(), transition: Transition.rightToLeft),
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().contactUsIcon,
              name: S.of(context).contactUs,
              onTap: () {
                Get.put(ContactInfoController());
                Get.to(ContactUsView(), transition: Transition.rightToLeft);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().passwordMenuIcon,
              name: S.of(context).changePassword,
              onTap: () => Get.to(
                ChangePasswordView(),
                transition: Transition.rightToLeft,
              ),
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().aboutUsIcon,
              name: S.of(context).aboutUs,
              onTap: () {
                Get.put(AboutUsController());
                Get.to(AboutUsView(), transition: Transition.rightToLeft);
              },
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().refundIcon,
              name: S.of(context).refundPolicy,
              onTap: () {},
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().termsIcon,
              name: S.of(context).termsConditions,
              onTap: () {},
            ),
            _buildMenuItem(
              context: context,
              icon: AppAssets().privacyIcon,
              name: S.of(context).privacyPolicy,
              onTap: () {},
            ),
            SizedBox(height: 17),
            _buildLogoutButton(),
            SizedBox(height: 3.2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String icon,
    required String name,
    required void Function()? onTap,
  }) {
    return Column(
      children: [
        SizedBox(height: 1.8.h),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              SvgPicture.asset(icon),
              SizedBox(width: 25),
              Text(
                name,
                style: TextStyle(color: AppColors().accentColor, fontSize: 20),
              ),
              Spacer(),
              SvgPicture.asset(
                name == S.of(context).aboutUs ||
                        name == S.of(context).refundPolicy ||
                        name == S.of(context).termsConditions ||
                        name == S.of(context).privacyPolicy
                    ? AppAssets().linkIcon
                    : AppAssets().arrowIcon,
              ),
            ],
          ),
        ),
        SizedBox(height: 1.8.h),
        SvgPicture.asset(AppAssets().seperator),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return TextButton(
      onPressed: () => LogoutSessionHelper.confirmLogout(),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors().logoutButton,
        side: BorderSide(color: AppColors().logoutButton, width: 2),
        padding: EdgeInsets.symmetric(vertical: 12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets().logoutIcon),
          SizedBox(width: 8),
          Text(
            S.of(Get.context!).logoutButton,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      ),
    );
  }
}
