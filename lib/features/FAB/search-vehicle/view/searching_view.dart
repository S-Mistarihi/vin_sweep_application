import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vin_sweep_application/features/FAB/search-vehicle/controller/searching_controller.dart';

import '../../../../configuration/app_assets.dart';
import '../../../../configuration/app_colors.dart';
import '../../../../generated/l10n.dart';

class SearchingView extends StatelessWidget {
  const SearchingView({super.key, required this.vinNumber});

  final String vinNumber;

  @override
  Widget build(BuildContext context) {
    Get.put(SearchingController(vinNumber: vinNumber));

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AppAssets().searchJsonIcon),
            Text(
              S.of(context).searchingForInfo,
              style: TextStyle(
                color: AppColors().textFieldLabelColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
