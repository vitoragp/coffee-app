import 'package:flutter/material.dart';

///
/// MainPage
///

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Main page"),
        ),
      ),
    );
  }
}
