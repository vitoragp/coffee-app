import 'package:coffee_base_app/core/main_application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  ///
  /// Login success
  ///
  group('Integration E2E Test', () {
    testWidgets('Login successfully', (WidgetTester tester) async {
      await tester.runAsync(() async {
        final app = Application(enableDebugMode: true, skipStorageData: true, debugModule: "success");
        await app.initialize();

        await tester.pumpWidget(app.build());

        expect(find.byKey(const ValueKey("LoginPage")), findsOneWidget);
        expect(find.byKey(const ValueKey("EmailTextField")), findsOneWidget);
        expect(find.byKey(const ValueKey("PasswordTextField")), findsOneWidget);
        expect(find.byKey(const ValueKey("LoginButton")), findsOneWidget);

        await tester.enterText(find.byKey(const ValueKey("EmailTextField")), "email@email.com");
        await tester.enterText(find.byKey(const ValueKey("PasswordTextField")), "12345678");

        await tester.ensureVisible(find.byKey(const ValueKey("LoginButton"), skipOffstage: false));
        await tester.tap(find.byKey(const ValueKey("LoginButton")));

        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey("MainPage")), findsOneWidget);
      });
    });

    testWidgets('Login fail', (WidgetTester tester) async {
      await tester.runAsync(() async {
        final app = Application(
          enableDebugMode: true,
          skipStorageData: true,
          debugModule: "success",
          setupSpecificModules: <String, String>{
            "user/login": "error",
          },
        );
        await app.initialize();

        await tester.pumpWidget(app.build());

        expect(find.byKey(const ValueKey("LoginPage")), findsOneWidget);
        expect(find.byKey(const ValueKey("EmailTextField")), findsOneWidget);
        expect(find.byKey(const ValueKey("PasswordTextField")), findsOneWidget);
        expect(find.byKey(const ValueKey("LoginButton")), findsOneWidget);

        await tester.enterText(find.byKey(const ValueKey("EmailTextField")), "email@email.com");
        await tester.enterText(find.byKey(const ValueKey("PasswordTextField")), "12345678");

        await tester.ensureVisible(find.byKey(const ValueKey("LoginButton")));
        await tester.tap(find.byKey(const ValueKey("LoginButton")));

        await tester.pumpAndSettle();

        expect(find.text("Usuário ou senha invalidos!"), findsOneWidget);
      });
    });

    testWidgets('Redirect: Login to register', (WidgetTester tester) async {
      await tester.runAsync(() async {
        final app = Application(enableDebugMode: true, skipStorageData: true, debugModule: "success");
        await app.initialize();

        await tester.pumpWidget(app.build());

        expect(find.byKey(const ValueKey("LoginPage")), findsOneWidget);

        await tester.tap(find.byKey(const ValueKey("RegisterLink")));

        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey("RegisterPage")), findsOneWidget);
      });
    });

    testWidgets('Redirect: Login to forgot password', (WidgetTester tester) async {
      await tester.runAsync(() async {
        final app = Application(enableDebugMode: true, skipStorageData: true, debugModule: "success");
        await app.initialize();

        await tester.pumpWidget(app.build());

        expect(find.byKey(const ValueKey("LoginPage")), findsOneWidget);

        await tester.tap(find.byKey(const ValueKey("ForgotPasswordLink")));

        await tester.pumpAndSettle();

        expect(find.byKey(const ValueKey("ForgotPasswordPage")), findsOneWidget);
      });
    });
  });
}
