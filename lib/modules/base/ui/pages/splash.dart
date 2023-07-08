import 'package:flutter/material.dart';

///
/// SplashPage
///

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Splash page"),
        ),
      ),
    );
  }
}
