import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

///
/// Typedef
///

typedef DeviceInfo = ({
  String model,
  String sn,
});

///
/// getModelAndSN
///

Future<DeviceInfo> getDeviceInformation() async {
  late String model, sn;
  var deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    var info = await deviceInfo.androidInfo;
    model = info.model;
    sn = info.serialNumber;
  } else {
    var info = await deviceInfo.iosInfo;
    model = info.model;
    sn = info.identifierForVendor ?? "";
  }
  return Future(
    () => (
      model: model,
      sn: sn,
    ),
  );
}
