import 'dart:convert';

import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/utils/async_call/index.dart';
import 'package:coffee_base_app/utils/server.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test server: success app/check', (WidgetTester tester) async {
    await tester.runAsync(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      var contentStr = await rootBundle.loadString(defaultMockedResponseFile);
      var content = jsonDecode(contentStr);

      var testEnvironment = AsyncCallDebugEnvironment(module: content["success"]);

      var response = await Server(
        testEnvironment: testEnvironment,
        logFunction: (_) {},
      ).appCheckWithModelAndSn("model", "sn");

      expect(response["http_success"], true);

      var body = response["body"] as Map<String, dynamic>;

      expect(body["session_token"], "45sdS-8fgcx0SDd54fs-1asd5C0s5-sd");
      expect(body["version"], "v1");
    });
  });

  testWidgets('Test server: error app/check', (WidgetTester tester) async {
    await tester.runAsync(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      var contentStr = await rootBundle.loadString(defaultMockedResponseFile);
      var content = jsonDecode(contentStr);

      var testEnvironment = AsyncCallDebugEnvironment(module: content["success"]);

      var response = await Server(
        testEnvironment: testEnvironment,
        logFunction: (_) {},
      ).appCheckWithModelAndSn("model", "sn");

      expect(response["http_success"], true);

      var body = response["body"] as Map<String, dynamic>;

      expect(body["session_token"], "45sdS-8fgcx0SDd54fs-1asd5C0s5-sd");
      expect(body["version"], isNot("v2"));
    });
  });
}
