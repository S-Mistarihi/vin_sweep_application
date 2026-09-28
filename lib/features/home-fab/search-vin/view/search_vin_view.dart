import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vin_sweep_application/configuration/app_assets.dart';
import 'package:vin_sweep_application/configuration/app_colors.dart';
import 'package:vin_sweep_application/features/home-fab/search-vin/controller/search_vin_controller.dart';

import '../../../../generated/l10n.dart';

class SearchVinView extends StatelessWidget {
  const SearchVinView({super.key, required this.vinNumber});

  final String vinNumber;

  @override
  Widget build(BuildContext context) {
    final SearchVinController controller = Get.put(
      SearchVinController(vinNumber: vinNumber),
    );

    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.isLoading.value
              ? Column(
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
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
