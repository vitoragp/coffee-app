import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/core/ui/pages/error.dart';
import 'package:coffee_base_app/core/ui/pages/login.dart';
import 'package:coffee_base_app/core/ui/pages/main.dart';
import 'package:coffee_base_app/core/ui/pages/register.dart';
import 'package:flutter/material.dart';

///
/// routes
///

routes() {
  return {
    AppRoutes.error: (context) => const ErrorPage(key: ValueKey("ErrorPage")),
    AppRoutes.main: (context) => const MainPage(key: ValueKey("MainPage")),
    AppRoutes.register: (context) => const RegisterPage(key: ValueKey("RegisterPage")),
    AppRoutes.login: (context) => const LoginPage(key: ValueKey("LoginPage")),
  };
}
