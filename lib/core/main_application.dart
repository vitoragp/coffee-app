import 'dart:convert';

import 'package:coffee_base_app/app_controller/index.dart';
import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/core/ui/pages/splash.dart';
import 'package:coffee_base_app/domain/models/user.dart';
import 'package:coffee_base_app/factories/model_factory.dart';
import 'package:coffee_base_app/routes.dart';
import 'package:coffee_base_app/services.dart';
import 'package:coffee_base_app/utils/async_call/index.dart';
import 'package:coffee_base_app/utils/platform.dart';
import 'package:coffee_base_app/utils/server.dart';
import 'package:coffee_base_app/utils/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// Application
///

class Application {
  Application({
    this.enableDebugMode,
    this.debugModule,
    this.skipStorageData,
    this.skipDeviceInformation,
    Function(String?)? logFunction,
  }) : _logFunction = logFunction ?? ((_) {});

  final bool? enableDebugMode;
  final bool? skipStorageData;
  final bool? skipDeviceInformation;
  final String? debugModule;

  final void Function(String?) _logFunction;

  User? _userData;
  User? get userData => _userData;

  bool _hasError = false;
  bool get hasError => _hasError;

  String? _error;
  String? get error => _error;

  DeviceInfo? _deviceInfo;
  DeviceInfo? get deviceInfo => _deviceInfo;

  String? _sessionToken;
  String? get sessionToken => _sessionToken;

  String? _apiVersion;
  String? get apiVersion => _apiVersion;

  late final AsyncCallDebugEnvironment? _testEnvironment;

  initialize() async {
    await Future.wait([
      Future(() async {
        await _initializeDebugEnvironment();
      }),
      Future(() async {
        await _initializeAppToken();
      }),
      Future(() async {
        await _initializeAppUser();
      }),
    ]);

    await _startConnectionWithServer();
  }

  setMockedUserData(User userData) {
    if (enableDebugMode == true) {
      _userData = userData;
    }
  }

  buildSplash() {
    return const _MyAppSplash();
  }

  build() {
    return _buildApplicationWithParams(
      deviceInfo: _deviceInfo!,
      sessionToken: _sessionToken,
      version: _apiVersion,
      errorMessage: _error,
      userData: _userData,
      testEnvironment: _testEnvironment,
    );
  }

  startSplash() {
    runApp(const _MyAppSplash());
  }

  start() {
    runApp(_buildApplicationWithParams(
      deviceInfo: _deviceInfo!,
      sessionToken: _sessionToken,
      version: _apiVersion,
      errorMessage: _error,
      userData: _userData,
      testEnvironment: _testEnvironment,
      logFunction: _logFunction,
    ));
  }

  initializeAndStart() async {
    startSplash();
    await initialize();
    start();
  }

  Future<void> _initializeDebugEnvironment() async {
    if (kDebugMode && enableDebugMode == true && debugModule != null) {
      var content = await rootBundle.loadString(defaultMockedResponseFile);
      var mockedModule = jsonDecode(content);
      _testEnvironment = AsyncCallDebugEnvironment(module: mockedModule[debugModule]);
    }
  }

  Future<void> _initializeAppToken() async {
    if (skipStorageData != true) {
      var storage = Storage();

      var hasSessionToken = await storage.contains(StorageKeys.sessionToken);
      _sessionToken = hasSessionToken ? await storage.read(StorageKeys.sessionToken) : null;

      var hasAppVersion = await storage.contains(StorageKeys.appVersion);
      _apiVersion = hasAppVersion ? await storage.read(StorageKeys.appVersion) : null;
    }
  }

  Future<void> _initializeAppUser() async {
    if (skipStorageData != true) {
      var storage = Storage();
      var hasUserConfiguration = await storage.contains(StorageKeys.userConfiguration);
      var userDataStr = hasUserConfiguration ? await storage.read(StorageKeys.userConfiguration) : null;
      _userData = hasUserConfiguration ? ModelFactory.deserialize<User>(jsonDecode(userDataStr!)) : null;
    }
  }

  _startConnectionWithServer() async {
    if (skipDeviceInformation != true) {
      _deviceInfo = await getDeviceInformation();
    } else {
      if (enableDebugMode == true) {
        _deviceInfo = DeviceInfo(model: "model", sn: "sn");
      }
    }

    final response = await Server(
      sessionToken: sessionToken,
      testEnvironment: _testEnvironment,
    ).appCheckWithModelAndSn(deviceInfo!.model, deviceInfo!.sn);

    if (response.containsKey("http_success")) {
      _hasError = response["http_success"] as bool == false;
    }

    switch (response) {
      case {"http_success": true, "body": Map body}:
        {
          _sessionToken = body["session_token"] as String;
          _apiVersion = body["version"] as String;
        }
      case {"http_success": false, "body": Map body}:
        {
          _error = body["message"] as String;
        }
    }
  }
}

///
/// _buildApplicationWithParams
///

_buildApplicationWithParams({
  final DeviceInfo? deviceInfo,
  final String? sessionToken,
  final String? version,
  final String? errorMessage,
  final User? userData,
  final AsyncCallDebugEnvironment? testEnvironment,
  final void Function(String?)? logFunction,
}) {
  return ServicesInheritedWidget(
    services: Services(
      server: Server(
        deviceInfo: deviceInfo,
        sessionToken: sessionToken,
        version: version,
        testEnvironment: testEnvironment,
        logFunction: logFunction,
      ),
      storage: Storage(),
    ),
    child: BlocProvider<AppBloc>(
      create: (context) => AppBloc(
        deviceInfo: deviceInfo!,
        sessionToken: sessionToken,
        version: version,
        errorMessage: errorMessage,
        userData: userData,
      ),
      child: _MyApp(
        initialRoute: switch (errorMessage) {
          null => userData != null ? AppRoutes.main : AppRoutes.login,
          _ => AppRoutes.error,
        },
      ),
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
/// _MyAppSplash
///

class _MyAppSplash extends StatelessWidget {
  const _MyAppSplash();

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
