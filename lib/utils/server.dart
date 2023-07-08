import 'package:coffee_base_app/utils/async_call/async_call.dart';
import 'package:coffee_base_app/constants.dart';

///
/// Typedefs
///

typedef ServerResponse = Future<Map<String, dynamic>>;

///
/// Server
///

class Server {
  static ServerResponse cep(String cep) async {
    return await AsyncCall().host("viacep.com.br").get("ws/$cep/json");
  }

  static ServerResponse appCheck() async {
    return await AsyncCall().host(defaultHost).get(appCheckRoute);
  }
}
