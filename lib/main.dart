import 'dart:convert';

import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/factories/model_factory.dart';
import 'package:coffee_base_app/domain/models/user.dart';
import 'package:coffee_base_app/core/ui/pages/splash.dart';
import 'package:coffee_base_app/routes.dart';
import 'package:coffee_base_app/utils/async_call/async_call_debug_environment.dart';
import 'package:coffee_base_app/utils/platform.dart';
import 'package:coffee_base_app/utils/server.dart';
import 'package:coffee_base_app/utils/storage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_controller/bloc.dart';

///
/// main
///
void main() async {
  String? sessionToken;
  String? version;
  String? errorMessage;
  DeviceInfo? deviceInfo;
  User? userData;
  AsyncCallDebugEnvironment? testEnvironment;

  WidgetsFlutterBinding.ensureInitialized();

  // Start splash

  runApp(const MyAppSplash());

  // Prepare all subsystems jobs.

  initializeDebugEnvironment() async {
    if (kDebugMode) {
      var content = await rootBundle.loadString(defaultMockedResponseFile);
      var mockedModule = jsonDecode(content);
      testEnvironment = AsyncCallDebugEnvironment(module: mockedModule["success"]);
    }
  }

  initializeAppToken() async {
    var storage = Storage();
    var hasSessionToken = await storage.contains(StorageKeys.sessionToken);
    sessionToken = hasSessionToken ? await storage.read(StorageKeys.sessionToken) : null;
  }

  initializeInitialRouteAndUserData() async {
    var storage = Storage();
    var hasUserConfiguration = await storage.contains(StorageKeys.userConfiguration);
    var userDataStr = hasUserConfiguration ? await storage.read(StorageKeys.userConfiguration) : null;

    userData = hasUserConfiguration ? ModelFactory.deserialize<User>(jsonDecode(userDataStr!)) : null;
  }

  // Start all subsystems

  await Future.wait([
    Future(initializeDebugEnvironment),
    Future(initializeAppToken),
    Future(initializeInitialRouteAndUserData),
  ]);

  // Prepare app authentication

  doAppCheckAndUpdateTokenAndVersion() async {
    deviceInfo = await getDeviceInformation();

    final response = await Server(
      sessionToken: sessionToken,
      testEnvironment: testEnvironment,
    ).appCheckWithModelAndSn(deviceInfo!.model, deviceInfo!.sn);

    switch (response) {
      case {"http_success": true, "body": Map body}:
        {
          sessionToken = body["session_token"] as String;
          version = body["version"] as String;
        }
      case {"http_success": false, "body": Map body}:
        {
          errorMessage = body["message"] as String;
        }
    }
  }

  // Start app authentication

  await Future.wait([
    Future(doAppCheckAndUpdateTokenAndVersion),
  ]);

  // Initialize app

  runApp(initializeApplication(
    deviceInfo: deviceInfo!,
    sessionToken: sessionToken,
    version: version,
    errorMessage: errorMessage,
    userData: userData,
    testEnvironment: testEnvironment,
  ));
}

///
/// Initialize application
///

initializeApplication({
  final DeviceInfo? deviceInfo,
  final String? sessionToken,
  final String? version,
  final String? errorMessage,
  final User? userData,
  final AsyncCallDebugEnvironment? testEnvironment,
  final void Function(String?)? logFunction,
}) {
  return BlocProvider<AppBloc>(
    create: (context) => AppBloc(
      deviceInfo: deviceInfo!,
      sessionToken: sessionToken,
      version: version,
      errorMessage: errorMessage,
      services: (
        server: Server(
          deviceInfo: deviceInfo,
          sessionToken: sessionToken,
          version: version,
          testEnvironment: testEnvironment,
          logFunction: logFunction,
        )
      ),
    ),
    child: _MyApp(
      initialRoute: switch (errorMessage) {
        null => userData != null ? '/Main' : '/Login',
        _ => '/Error',
      },
    ),
  );
}

///
/// _MyApp
///

class _MyApp extends StatelessWidget {
  final String initialRoute;

  const _MyApp({
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: initialRoute,
      routes: routes(),
    );
  }
}

///
/// MyAppSplash
///

class MyAppSplash extends StatelessWidget {
  final String? message;
  const MyAppSplash({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashPage(key: ValueKey("SplashPage")),
    );
  }
}
