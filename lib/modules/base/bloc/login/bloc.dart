import 'package:coffee_base_app/utils/async_call/async_call.dart';
import 'package:coffee_base_app/constants.dart';

import 'events.dart';
import 'states.dart';
import 'package:bloc/bloc.dart';

///
/// LoginBloc
///

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<LoginOnSuccess>((event, emit) => LoginState(userData: event.userData));
    on<LoginOnFail>((event, emit) => LoginState(errorMessage: event.message));
  }

  login(String email, String password) async {
    var response = await AsyncCall().host(ServerInfo.defaultHost).body({
      "email": email,
      "password": password,
    }).post("");

    switch (response) {
      case {"http_success": true, "body": Map<String, dynamic> body}:
        {
          add(LoginOnSuccess(userData: body));
        }
      case {"body": Map<String, dynamic> body}:
        {
          add(LoginOnFail(message: body["message"] as String));
        }
    }
  }
}
