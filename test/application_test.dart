import 'dart:convert';

import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/domain/models/user.dart';
import 'package:coffee_base_app/main.dart';
import 'package:coffee_base_app/utils/async_call/index.dart';
import 'package:coffee_base_app/utils/server.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// main
///

void main() {
  testWidgets('Splash initialization', (WidgetTester tester) async {
    await tester.pumpWidget(const MyAppSplash());
    expect(find.byKey(const ValueKey("SplashPage")), findsOneWidget);
  });

  testWidgets('Complete error initialization', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      String? sessionToken;
      String? version;
      String? errorMessage;
      AsyncCallDebugEnvironment? testEnvironment;

      // Prepare all subsystems jobs.

      initializeTestEnvironment() async {
        var content = await rootBundle.loadString(defaultMockedResponseFile);
        var mockedModule = jsonDecode(content);
        testEnvironment = AsyncCallDebugEnvironment(module: mockedModule["error"]);
      }

      // Start all subsystems

      await Future.wait([
        Future(initializeTestEnvironment),
      ]);

      // Prepare app authentication

      doAppCheckAndUpdateTokenAndVersion() async {
        switch (await Server(
          sessionToken: sessionToken,
          testEnvironment: testEnvironment,
          logFunction: (_) {},
        ).appCheckWithModelAndSn("model", "sn")) {
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

      await tester.pumpWidget(initializeApplication(
        sessionToken: sessionToken,
        errorMessage: errorMessage,
        deviceInfo: (model: "model", sn: "sn"),
        version: version,
        testEnvironment: testEnvironment,
        logFunction: (_) {},
      ));

      expect(find.byKey(const ValueKey("ErrorPage")), findsOneWidget);
      expect(find.text("Invalid/incorrect request information"), findsOneWidget);
    });
  });

  testWidgets('Complete unauthenticated successfully initialization', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      String? sessionToken;
      String? version;
      String? errorMessage;
      AsyncCallDebugEnvironment? testEnvironment;

      // Prepare all subsystems jobs.

      initializeTestEnvironment() async {
        var content = await rootBundle.loadString(defaultMockedResponseFile);
        var mockedModule = jsonDecode(content);
        testEnvironment = AsyncCallDebugEnvironment(module: mockedModule["success"]);
      }

      // Start all subsystems

      await Future.wait([
        Future(initializeTestEnvironment),
      ]);

      // Prepare app authentication

      doAppCheckAndUpdateTokenAndVersion() async {
        switch (await Server(
          sessionToken: sessionToken,
          testEnvironment: testEnvironment,
          logFunction: (_) {},
        ).appCheckWithModelAndSn("model", "sn")) {
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

      expect(sessionToken, "45sdS-8fgcx0SDd54fs-1asd5C0s5-sd");
      expect(version, "v1");

      expect(errorMessage, null);

      await tester.pumpWidget(initializeApplication(
        sessionToken: sessionToken,
        errorMessage: errorMessage,
        deviceInfo: (model: "model", sn: "sn"),
        version: version,
        userData: null,
        testEnvironment: testEnvironment,
        logFunction: (_) {},
      ));

      expect(find.byKey(const ValueKey("LoginPage")), findsOneWidget);
    });
  });

  testWidgets('Complete authenticated successfully initialization', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      String? sessionToken;
      String? version;
      String? errorMessage;
      User? userData;
      AsyncCallDebugEnvironment? testEnvironment;

      // Prepare all subsystems jobs.

      initializeTestEnvironment() async {
        var content = await rootBundle.loadString(defaultMockedResponseFile);
        var mockedModule = jsonDecode(content);
        testEnvironment = AsyncCallDebugEnvironment(module: mockedModule["success"]);
      }

      initializeUserData() async {
        userData = User(id: "1", firstName: "John", lastName: "Doe", email: "john@email.com");
      }

      // Start all subsystems

      await Future.wait([
        Future(initializeTestEnvironment),
        Future(initializeUserData),
      ]);

      // Prepare app authentication

      doAppCheckAndUpdateTokenAndVersion() async {
        switch (await Server(
          sessionToken: sessionToken,
          testEnvironment: testEnvironment,
          logFunction: (_) {},
        ).appCheckWithModelAndSn("model", "sn")) {
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

      expect(sessionToken, "45sdS-8fgcx0SDd54fs-1asd5C0s5-sd");
      expect(version, "v1");

      expect(errorMessage, null);
      expect(userData, isNot(null));

      expect(userData!.id, "1");
      expect(userData!.firstName, "John");
      expect(userData!.lastName, "Doe");
      expect(userData!.email, "john@email.com");

      await tester.pumpWidget(initializeApplication(
        sessionToken: sessionToken,
        deviceInfo: (model: "model", sn: "sn"),
        errorMessage: errorMessage,
        version: version,
        userData: userData,
        testEnvironment: testEnvironment,
        logFunction: (_) {},
      ));

      expect(find.byKey(const ValueKey("MainPage")), findsOneWidget);
    });
  });
}
