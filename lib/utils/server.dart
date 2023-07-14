import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/utils/async_call/index.dart';
import 'package:coffee_base_app/utils/platform.dart';

///
/// Typedefs
///

typedef ServerResponse = Future<Map<String, dynamic>>;

///
/// Server
///

class Server {
  final AsyncCallDebugEnvironment? testEnvironment;

  final String? sessionToken;
  final String? version;

  final DeviceInfo? deviceInfo;

  final void Function(String?)? logFunction;

  const Server({
    this.sessionToken,
    this.version,
    this.testEnvironment,
    this.logFunction,
    this.deviceInfo,
  });

  ServerResponse cep(String cep) async {
    return await AsyncCall(
      testEnvironment: testEnvironment,
      logFunction: logFunction,
    ).host("viacep.com.br").get("ws/$cep/json");
  }

  ServerResponse appCheck() async {
    final requestBody = <String, dynamic>{
      "model": deviceInfo!.model,
      "sn": deviceInfo!.sn,
    };

    if (sessionToken != null) {
      requestBody["session_token"] = sessionToken;
    }
    return await AsyncCall(
      testEnvironment: testEnvironment,
      logFunction: logFunction,
    ).host(ServerInfo.defaultHost).body(requestBody).post(ServerInfo.appCheckRoute);
  }

  ServerResponse appCheckWithModelAndSn(String model, String sn) async {
    final requestBody = <String, dynamic>{
      "model": model,
      "sn": sn,
    };

    if (sessionToken != null) {
      requestBody["session_token"] = sessionToken;
    }
    return await AsyncCall(
      testEnvironment: testEnvironment,
      logFunction: logFunction,
    ).host(ServerInfo.defaultHost).body(requestBody).post(ServerInfo.appCheckRoute);
  }

  ServerResponse startSession(String userId) async {
    return await AsyncCall(
      testEnvironment: testEnvironment,
      logFunction: logFunction,
    ).host(ServerInfo.defaultHost).body({
      "user_id": userId,
      "session_token": sessionToken,
    }).post(ServerInfo.startSessionRoute);
  }

  ServerResponse login(String userName, String password) async {
    return await AsyncCall(
      testEnvironment: testEnvironment,
      logFunction: logFunction,
    ).host(ServerInfo.defaultHost).body({
      "username": userName,
      "password": password,
    }).post(ServerInfo.startSessionRoute);
  }
}
