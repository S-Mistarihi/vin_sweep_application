import 'package:flutter/material.dart';
import 'package:vin_sweep_application/utils/ui/custom_persistent_bottom_nav_bar.dart';

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        body: CustomPersistentBottomNavBar(),
      ),
    );
  }
}
