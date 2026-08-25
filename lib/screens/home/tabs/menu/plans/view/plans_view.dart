import 'package:flutter/material.dart';

import '../../../../../../configuration/app_assets.dart';
import '../../../../../../utils/ui/common/custom_main_header.dart';

class PlansView extends StatelessWidget {
  const PlansView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomMainHeader(
            headerSpace: 25,
            headerMainText: 'My Plans',
            leftIcon: AppAssets().backIcon,
          ),
        ],
      ),
    );
  }
}
