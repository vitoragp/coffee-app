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

  ServerResponse appCheck(String? sessionToken) async {
    final requestBody = {};

    if (sessionToken != null) {
      requestBody["session_token"] = sessionToken;
    }

    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var info = await deviceInfo.androidInfo;
      requestBody["model"] = info.model;
      requestBody["sn"] = info.serialNumber;
    } else {
      var info = await deviceInfo.iosInfo;
      requestBody["model"] = info.model;
      requestBody["sn"] = info.identifierForVendor ?? "";
    }
    return await AsyncCall().host(ServerInfo.defaultHost).body(requestBody).post(ServerInfo.appCheckRoute);
  }
}
