import 'package:flutter/material.dart';

///
/// ForgotPasswordPage
///

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordPage();
  }
}

///
/// _ForgotPasswordPage
///

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Forgot password page"),
        ),
      ),
    );
  }
}
