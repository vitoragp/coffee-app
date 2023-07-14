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
    "/Error": (context) => const ErrorPage(key: ValueKey("ErrorPage")),
    "/Main": (context) => const MainPage(key: ValueKey("MainPage")),
    "/Register": (context) => const RegisterPage(key: ValueKey("RegisterPage")),
    "/Login": (context) => const LoginPage(key: ValueKey("LoginPage")),
  };
}
