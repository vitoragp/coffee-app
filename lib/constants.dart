///
/// Default general values
///

const defaultMockedResponseFile = "assets/mocked_responses/mocked_json_response.json";

const headerKey = "X-Magic-Nm";

const appName = "CoffeeApp";

///
/// Server
///

class ServerInfo {
  static const defaultHost = "localhost";

  static const appCheckRoute = "app/check";

  static const startSessionRoute = "app/start_session";
}

///
/// Storage keys
///

class StorageKeys {
  static const userConfiguration = "user_configuration_k";
  static const sessionToken = "app_token_k";
}
