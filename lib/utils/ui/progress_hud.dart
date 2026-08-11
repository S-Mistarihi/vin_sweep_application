import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../configuration/app_assets.dart';
import '../../configuration/app_colors.dart';

//import '../../configuration/app_colors.dart';

class ProgressHud {
  static ProgressHud shared = ProgressHud(); // singleton
  BuildContext? context;

  Widget createLoadingView({
    Color? color,
    bool isLoadMore = false,
    double size = 50.0,
  }) {
    return Stack(
      children: <Widget>[
        getCircularProgressIndicator(
          color: color ?? AppColors().closeIconDialogBackgroundColor,
          size: size,
          isLoadMore: isLoadMore,
        ),
      ],
    );
  }

  Widget spinKitThreeInOut({double size = 50.0}) {
    return SpinKitFadingCircle(
      size: size,
      itemBuilder: (BuildContext context, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            color: AppColors().closeIconDialogBackgroundColor,
          ),
        );
      },
    );
  }

  Widget getCircularProgressIndicator({
    Color? color,
    bool isLoadMore = false,
    double size = 50.0,
  }) => Center(
    child: isLoadMore
        ? SpinKitRipple(color: color, size: size)
        : Container(
      margin: EdgeInsets.only(right: 20.w),
      child: Lottie.asset(
        AppAssets().loadingSplashLogo,
        repeat: true,
        width: 60.w,
      ),
    ),
  );

  void startLoading(BuildContext context, {bool useScanLoading = false}) {
    ProgressHud.shared.context = context;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return createLoadingView(size: 70);
      },
    );
  }

  void stopLoading() async {
    if (ProgressHud.shared.context != null) {
      Navigator.of(Get.context!, rootNavigator: false).pop('Discard');
    }
  }
}
