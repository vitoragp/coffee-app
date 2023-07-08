import 'package:coffee_base_app/modules/base/ui/pages/error.dart';
import 'package:coffee_base_app/modules/base/ui/pages/login.dart';
import 'package:coffee_base_app/modules/base/ui/pages/main.dart';
import 'package:flutter/material.dart';

///
/// routes
///

routes() {
  return {
    "/Error": (context) => const ErrorPage(key: ValueKey("ErrorPage")),
    "/Main": (context) => const MainPage(key: ValueKey("MainPage")),
    "/Login": (context) => const LoginPage(key: ValueKey("LoginPage")),
  };
}
