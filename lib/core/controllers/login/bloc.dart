import 'dart:async';

import 'package:coffee_base_app/factories/model_factory.dart';
import 'package:coffee_base_app/domain/models/user.dart';
import 'package:coffee_base_app/utils/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'states.dart';

///
/// LoginBloc
///

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginStateInitial()) {
    on(_mapEventToState);
  }

  FutureOr<void> _mapEventToState(LoginEvent event, Emitter<LoginState> emit) {
    switch (event) {
      case LoginEventSuccess(:User user):
        {
          emit(LoginStateSuccess(user: user));
        }

      case LoginEventError(:String message):
        {
          emit(LoginStateError(message: message));
        }

      case LoginEventLoading():
        {
          emit(LoginStateLoading());
        }
    }
  }

  tryLogin(Server server, String userName, String password) async {
    add(LoginEventLoading());

    switch (await server.login(userName, password)) {
      case {"http_success": true, "body": Map body}:
        {
          switch (await server.startSession(body["id"] as String)) {
            case {"http_success": true}:
              {
                switch (ModelFactory.deserialize<User>(Map.from(body))) {
                  case User user:
                    add(LoginEventSuccess(user: user));
                  case _:
                    add(LoginEventError(message: "Failed to deserialize user data!"));
                }
              }
            case {"http_success": false, "body": Map bodyStartSession}:
              {
                add(LoginEventError(message: bodyStartSession["message"] as String));
              }
          }
        }
      case {"http_success": false, "body": Map body}:
        {
          add(LoginEventError(message: body["message"] as String));
        }
    }
  }

  ///
  /// of
  ///

  static LoginBloc of(BuildContext context, {bool listen = false}) {
    return BlocProvider.of(context, listen: listen);
  }
}
