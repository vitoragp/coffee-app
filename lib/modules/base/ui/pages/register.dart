import 'package:flutter/material.dart';

///
/// RegisterPage
///

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

///
/// _RegisterPageState
///

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Login page"),
        ),
      ),
    );
  }
}
