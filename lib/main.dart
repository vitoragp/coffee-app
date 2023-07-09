import 'dart:convert';

import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/data_factories/models/model_factory.dart';
import 'package:coffee_base_app/models/user.dart';
import 'package:coffee_base_app/modules/base/ui/pages/splash.dart';
import 'package:coffee_base_app/routes.dart';
import 'package:coffee_base_app/types.dart';
import 'package:coffee_base_app/utils/async_call/async_call_debug_environment.dart';
import 'package:coffee_base_app/utils/server.dart';
import 'package:coffee_base_app/utils/storage.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_bloc/bloc.dart';

///
/// main
///

void main() async {
  String? initialRoute;
  String? appToken;
  String? appVersion;
  String? errorMessage;
  User? userData;
  Server server = Server();

  WidgetsFlutterBinding.ensureInitialized();

  // Start splash

  runApp(const MyAppSplash());

  // Auxiliary jobs.

  initializeDebugEnvironment() async {
    if (kDebugMode) {
      var content = await rootBundle.loadString(defaultMockedResponseFile);
      var mockedModule = jsonDecode(content);
      AsyncCallDebugEnvironment.ensureInitialized(module: mockedModule["success"]);
    }
  }

  initializeAppToken() async {
    var storage = Storage();
    var hasAppToken = await storage.contains(StorageKeys.appToken);
    appToken = hasAppToken ? await storage.read(StorageKeys.appToken) : null;
  }

  initializeInitialRouteAndUserData() async {
    var storage = Storage();
    var hasUserConfiguration = await storage.contains(StorageKeys.userConfiguration);
    var userDataStr = hasUserConfiguration ? await storage.read(StorageKeys.userConfiguration) : null;

    initialRoute = hasUserConfiguration ? '/Main' : '/Login';
    userData = hasUserConfiguration ? ModelFactory.deserialize<User>(jsonDecode(userDataStr!)) : null;
  }

  await Future.wait([
    Future(initializeDebugEnvironment),
    Future(initializeAppToken),
    Future(initializeInitialRouteAndUserData),
  ]);

  doAppCheckAndUpdateTokenAndVersion() async {
    switch (await server.appCheck(appToken)) {
      case {"http_success": true, "body": Map body}:
        {
          appToken = body["session_token"] as String;
          appVersion = body["version"] as String;
        }
      case {"http_success": false, "body": Map body}:
        {
          errorMessage = body["message"] as String;
          initialRoute = "/Error";
        }
    }
  }

  await Future.wait([
    Future(doAppCheckAndUpdateTokenAndVersion),
  ]);

  runApp(MyApp(
    initialRoute: initialRoute!,
    userData: userData,
    appToken: appToken,
    appVersion: appVersion,
    errorMessage: errorMessage,
    services: (server: server),
  ));
}

///
/// MyApp
///

class MyApp extends StatelessWidget {
  final String initialRoute;
  final String? appToken;
  final String? appVersion;
  final String? errorMessage;
  final User? userData;
  final Services services;

  const MyApp({
    super.key,
    required this.initialRoute,
    required this.appToken,
    required this.appVersion,
    required this.errorMessage,
    required this.userData,
    required this.services,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc(services: services, errorMessage: errorMessage),
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        initialRoute: initialRoute,
        routes: routes(),
      ),
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
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SplashPage(),
    );
  }
}
