import 'package:flutter/material.dart';
import 'package:vin_sweep_application/utils/ui/custom_persistent_bottom_nav_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('HomeScreen',style: TextStyle(color: Colors.white,fontSize: 28),),
          backgroundColor: Colors.green,
        ),
        body: CustomPersistentBottomNavBar(),
      ),
    );
  }
}
