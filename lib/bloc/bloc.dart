import 'package:bloc/bloc.dart';
import 'package:coffee_base_app/utils/server.dart';

import 'events.dart';
import 'state.dart';

///
/// AppBloc
///

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppState()) {
    on<AppEventInitialize>((event, emit) => emit(
          AppState(
            appToken: event.appToken,
            version: event.version,
          ),
        ));

    on<AppEventFailedToInitialize>((event, emit) => emit(
          AppState(
            error: event.error,
          ),
        ));
  }

  void startAppChecking() async {
    switch (await Server.appCheck()) {
      case {"http_success": true, "body": Map<String, dynamic> body}:
        {
          add(AppEventInitialize(
            appToken: body["session_token"] as String,
            version: body["version"] as String,
          ));
        }
      default:
        {
          add(AppEventFailedToInitialize(
            error: "Failed to initialize application!",
          ));
        }
    }
  }

  bool hasError() {
    return state.error != null;
  }
}
