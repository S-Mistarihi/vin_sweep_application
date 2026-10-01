import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';

import '../../../../../../../configuration/app_colors.dart';
import '../../../../../../../generated/l10n.dart';
import '../../../../../../../utils/ui/app_confirmation_dialog.dart';
import '../model/payment_method_response.dart';

class PaymentMethodCard extends StatelessWidget {
  final PayMethod method;
  final VoidCallback onSetDefault;
  final VoidCallback onDelete;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.onSetDefault,
    required this.onDelete,
  });

  /// اسأل الباك وين آخر 4 أرقام: بالـ metadata ولا بالـ displayName
  String get _maskedNumber {
    final source = (method.metadata.isNotEmpty
        ? method.metadata
        : method.displayName);
    final digits = source.replaceAll(RegExp(r'\D'), '');
    final last4 = digits.length >= 4
        ? digits.substring(digits.length - 4)
        : digits;
    return '**** **** **** $last4';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors().baseColor,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: AppColors().switcherBackgroundColor),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets().payCard, width: 46, height: 46),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors().textFieldLabelColor,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _maskedNumber,
                  style: TextStyle(
                    color: AppColors().accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (method.resultDefault)
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      S.of(context).defaultLabel,
                      style: TextStyle(
                        color: AppColors().defualtTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _buildBottomSheet();
            },
            child: SvgPicture.asset(AppAssets().payMenuIcon),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildBottomSheet() {
    return Get.bottomSheet(
      backgroundColor: AppColors().baseColor,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: AppColors().closeIconDialogColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  Text(
                    S.of(Get.context!).moreActions,
                    style: TextStyle(
                      color: AppColors().accentColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors().generalInfoContainerBorder,
                        shape: BoxShape.circle,
                      ),
                      child: Transform.scale(
                        scale: .5,
                        child: SvgPicture.asset(
                          AppAssets().closeIcon,
                          width: 12,
                          height: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Get.back();
              onSetDefault();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                S.of(Get.context!).makeDefault,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Divider(thickness: 2, color: AppColors().payBottomSheetLine),
          ),
          SizedBox(height: 25),
          InkWell(
            onTap: () {
              Get.back();
              _showDeleteDialog();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                S.of(Get.context!).deleteButton,
                style: TextStyle(
                  color: AppColors().accentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(height: 3.h),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppAssets().copyRightIcon,
              width: 212,
              height: 12,
            ),
          ),
          SizedBox(height: 3.h),
        ],
      ),
    );
  }

  void _showDeleteDialog() {
    AppConfirmationDialog.show(
      title: S.of(Get.context!).deletePaymentMethod,
      message: 'Are you sure you want to delete\n$_maskedNumber?',
      confirmText: S.of(Get.context!).deleteButton,
      onConfirm: onDelete,
    );
  }
}
