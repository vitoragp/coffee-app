import 'dart:convert';

import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/models/user.dart';
import 'package:coffee_base_app/modules/base/ui/pages/splash.dart';
import 'package:coffee_base_app/routes.dart';
import 'package:coffee_base_app/utils/async_call/async_call_debug_environment.dart';
import 'package:coffee_base_app/utils/storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

///
/// main
///

void main() async {
  late String initialRoute;
  User? userData;

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyAppSplash());

  await Future.wait([
    Future(() async {
      var content = await rootBundle.loadString(defaultMockedResponseFile);
      var mockedModule = jsonDecode(content);
      AsyncCallDebugEnvironment.ensureInitialized(module: mockedModule);
    }),
    Future(() async {
      var storage = Storage();
      var hasUserConfiguration = await storage.contains(userConfigurationKey);

      initialRoute = hasUserConfiguration ? '/Main' : '/Login';

      if (hasUserConfiguration) {
        userData = await storage.read<User>(userConfigurationKey);
      }
    }),
  ]);

  runApp(MyApp(
    initialRoute: initialRoute,
    userData: userData,
  ));
}

///
/// MyApp
///

class MyApp extends StatelessWidget {
  final String initialRoute;
  final User? userData;

  const MyApp({
    super.key,
    required this.initialRoute,
    required this.userData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => AppBloc(),
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
  const MyAppSplash({super.key});

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
