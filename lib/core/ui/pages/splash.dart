import 'package:coffee_base_app/constants.dart';
import 'package:flutter/material.dart';

///
/// SplashPage
///

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.yellowL1,
      body: SafeArea(
        child: Center(
          child: Text("Splash page"),
        ),
      ),
    );
  }
}
