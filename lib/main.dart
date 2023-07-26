import 'package:coffee_base_app/core/main_application.dart';
import 'package:flutter/material.dart';

///
/// main
///
void main() async {
  final app = Application(
    enableDebugMode: true,
    skipStorageData: false,
    skipDeviceInformation: false,
    debugModule: "success",
    logFunction: (value) => debugPrint(value),
  );

  WidgetsFlutterBinding.ensureInitialized();

  await app.initializeAndStart();
}
