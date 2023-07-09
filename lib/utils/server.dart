import 'dart:io';

import 'package:coffee_base_app/utils/async_call/async_call.dart';
import 'package:coffee_base_app/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';

///
/// Typedefs
///

typedef ServerResponse = Future<Map<String, dynamic>>;

///
/// Server
///

class Server {
  ServerResponse cep(String cep) async {
    return await AsyncCall().host("viacep.com.br").get("ws/$cep/json");
  }

  ServerResponse appCheck(String? appToken) async {
    late String model;
    late String sn;

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

    return await AsyncCall().host(ServerInfo.defaultHost).body({
      "appToken": appToken ?? "",
      "model": model,
      "sn": sn,
    }).post(ServerInfo.appCheckRoute);
  }
}
