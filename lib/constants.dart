import 'package:flutter/widgets.dart';

///
/// Default general values
///

const defaultMockedResponseFile = "assets/mocked_responses/mocked_json_response.json";

const headerKey = "X-Magic-Nm";

const appName = "CoffeeApp";

const defaultErrorMessage = "Erro desconhecido!";

///
/// Server
///

class ServerInfo {
  static const defaultHost = "localhost";
  static const appCheckRoute = "app/check";
  static const startSessionRoute = "app/start_session";
  static const loginRoute = "user/login";
}

///
/// AppColors
///

class AppColors {
  static const blueLight = Color(0xFF5398FF);
  static const blueDark = Color(0xFF0067FF);

  static const orangeLight = Color(0xFFFF9956);
  static const orangeDark = Color(0xFFFF6400);

  static const yellowL1 = Color(0xFFFFFAE5);
  static const yellowL2 = Color(0xFFFFEC9E);
  static const yellowD1 = Color(0xFFFFDD56);
  static const yellowD2 = Color(0xFFFFD325);

  static const redC1 = Color(0xFFFF8484);
  static const redC2 = Color(0xFFDA3F3F);
  static const redC3 = Color(0xFFAB2121);

  static const greyC1 = Color(0xFF777777);
  static const greyC2 = Color(0xFF333333);

  static const white = Color(0xFFFFFFFF);
  static const dark = Color(0xFF000000);
}

///
/// AppRoutes
///

class AppRoutes {
  static const register = "/register";
  static const login = "/login";
  static const main = "/main";
  static const error = "/error";
}

///
/// Storage keys
///

class StorageKeys {
  static const userConfiguration = "user_configuration_k";
  static const sessionToken = "app_token_k";
  static const appVersion = "app_version_k";
}
