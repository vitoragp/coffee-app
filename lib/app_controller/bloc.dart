import 'dart:async';

import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/domain/models/user.dart';
import 'package:coffee_base_app/services.dart';
import 'package:coffee_base_app/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'events.dart';
import 'state.dart';

///
/// AppBloc
///

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required DeviceInfo deviceInfo,
    required String? errorMessage,
    required String? sessionToken,
    required String? version,
    required User? userData,
  }) : super(
          AppState(
            deviceInfo: deviceInfo,
            sessionToken: sessionToken,
            user: userData,
            version: version,
            error: errorMessage,
          ),
        ) {
    on(_mapEventToState);
  }

  FutureOr<void> _mapEventToState(
    AppEvent event,
    Emitter<AppState> emit,
  ) {
    switch (event) {
      case AppEventSuccessAppCheck():
        {
          emit(state.copyWith(sessionToken: event.appToken, version: event.appVersion));
        }

      case AppEventThrowError():
        {
          emit(state.copyWith(error: event.error));
        }

      case AppEventLogin(:User user):
        {
          emit(state.copyWith(user: user));
        }

      case AppEventLogout():
        {
          emit(state.copyWith(cleanUpFlag: true, user: null));
        }

      case AppEventSetConnectionState():
        {
          emit(state.copyWith(connectionFlag: event.connectionState));
        }
    }
  }

  startSession(
    BuildContext context, {
    required String appToken,
    required String appVersion,
  }) {
    final services = Services.of(context);

    services.storage.write(StorageKeys.sessionToken, appToken);
    services.storage.write(StorageKeys.appVersion, appVersion);

    add(AppEventSuccessAppCheck(appToken: appToken, appVersion: appVersion));
  }

  throwError(String error) {
    add(AppEventThrowError(error: error));
  }

  login(BuildContext context, User user) {
    final services = Services.of(context);

    services.storage.writeModel<User>(StorageKeys.userConfiguration, user);

    add(AppEventLogin(user: user));
  }

  loginAndRedirect(BuildContext context, User user, String route) {
    final services = Services.of(context);

    services.storage.writeModel<User>(StorageKeys.userConfiguration, user);

    add(AppEventLogin(user: user));
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }

  logout(BuildContext context) {
    final services = Services.of(context);

    services.storage.delete(StorageKeys.sessionToken);
    services.storage.delete(StorageKeys.appVersion);
    services.storage.delete(StorageKeys.userConfiguration);

    add(AppEventLogout());
  }

  logoutAndRedirect(BuildContext context, String route) {
    final services = Services.of(context);

    services.storage.delete(StorageKeys.sessionToken);
    services.storage.delete(StorageKeys.appVersion);
    services.storage.delete(StorageKeys.userConfiguration);

    add(AppEventLogout());
    Navigator.of(context).pushNamedAndRemoveUntil(route, (_) => false);
  }

  ///
  /// Services
  ///

  static AppBloc of(BuildContext context, {bool listen = false}) {
    return BlocProvider.of<AppBloc>(context, listen: listen);
  }
}
