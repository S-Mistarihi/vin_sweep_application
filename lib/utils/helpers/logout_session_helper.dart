import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:vin_sweep_application/utils/ui/app_confirmation_dialog.dart';

import '../../configuration/cache_keys.dart';
import '../../configuration/current_session.dart';
import '../../features/auth/auth_view.dart';
import '../../features/home/tabs/home/controller/home_controller.dart';
import '../../features/home/tabs/menu/payment/pay-history/controller/payment_history_controller.dart';
import '../../features/home/tabs/menu/payment/pay-method/controller/payment_method_controller.dart';
import '../../features/home/tabs/menu/payment/payment_mode_controller.dart';
import '../../features/home/tabs/menu/plans/controller/plans_controller.dart';
import '../../features/home/tabs/menu/profile/controller/profile_controller.dart';
import '../../features/reports/controller/reports_history_controller.dart';

class LogoutSessionHelper {
  LogoutSessionHelper._private();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static void confirmLogout() {
    AppConfirmationDialog.show(
      title: 'Logout',
      desc: 'Are you sure you want to log out?',
      cancelText: 'Exit',
      okText: 'Ok',
      onCancel: () => Get.back(),
      onConfirm: () => logout(),
    );
  }

  static Future<void> logout() async {
    await _secureStorage.delete(key: CacheKeys.password);

    CurrentSession().clear();

    _drop<HomeController>();
    _drop<PlansController>();
    _drop<ReportsHistoryController>();
    _drop<ProfileController>();
    _drop<PaymentMethodController>();
    _drop<PaymentHistoryController>();
    _drop<PaymentModeController>();

    Get.offAll(() => AuthView());
  }

  static void _drop<T>() {
    if (Get.isRegistered<T>()) Get.delete<T>(force: true);
  }
}
