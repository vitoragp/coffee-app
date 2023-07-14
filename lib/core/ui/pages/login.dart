import 'package:flutter/material.dart';

///
/// LoginPage
///

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

///
/// _LoginPageState
///

class _LoginPageState extends State<LoginPage> {
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
