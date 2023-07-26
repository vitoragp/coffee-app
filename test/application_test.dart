import 'package:coffee_base_app/core/main_application.dart';
import 'package:coffee_base_app/domain/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

///
/// main
///

void main() {
  ///
  /// Application initialization
  ///

  testWidgets('Splash initialization', (WidgetTester tester) async {
    final app = Application(enableDebugMode: true, skipStorageData: true);
    await tester.pumpWidget(app.buildSplash());
    expect(find.byKey(const ValueKey("SplashPage")), findsOneWidget);
  });

  testWidgets('Complete error initialization', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      final app = Application(
        enableDebugMode: true,
        skipStorageData: true,
        skipDeviceInformation: true,
        debugModule: "error",
      );

      await app.initialize();

      await tester.pumpWidget(app.build());

      expect(find.byKey(const ValueKey("ErrorPage")), findsOneWidget);
      expect(find.text("Invalid/incorrect request information"), findsOneWidget);
    });
  });

  testWidgets('Complete unauthenticated successfully initialization', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      final app = Application(
        enableDebugMode: true,
        skipStorageData: true,
        skipDeviceInformation: true,
        debugModule: "success",
      );

      await app.initialize();

      expect(app.sessionToken, "45sdS-8fgcx0SDd54fs-1asd5C0s5-sd");
      expect(app.apiVersion, "v1");

      expect(app.error, null);

      await tester.pumpWidget(app.build());

      expect(find.byKey(const ValueKey("LoginPage")), findsOneWidget);
    });
  });

  testWidgets('Complete authenticated successfully initialization', (WidgetTester tester) async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await tester.runAsync(() async {
      final app = Application(
        enableDebugMode: true,
        skipStorageData: true,
        skipDeviceInformation: true,
        debugModule: "success",
      );

      await app.initialize();

      app.setMockedUserData(User(id: "1", firstName: "John", lastName: "Doe", email: "john@email.com"));

      expect(app.sessionToken, "45sdS-8fgcx0SDd54fs-1asd5C0s5-sd");
      expect(app.apiVersion, "v1");

      expect(app.error, null);
      expect(app.userData, isNot(null));

      expect(app.userData!.id, "1");
      expect(app.userData!.firstName, "John");
      expect(app.userData!.lastName, "Doe");
      expect(app.userData!.email, "john@email.com");

      await tester.pumpWidget(app.build());

      expect(find.byKey(const ValueKey("MainPage")), findsOneWidget);
    });
  });

  ///
  /// Application initialization
  ///
}
