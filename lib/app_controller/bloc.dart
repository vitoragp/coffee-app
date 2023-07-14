import 'dart:async';

import 'package:coffee_base_app/types.dart';
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
    required Services services,
    required DeviceInfo deviceInfo,
    required String? errorMessage,
    required String? sessionToken,
    required String? version,
  }) : super(
          AppState(
            services: services,
            deviceInfo: deviceInfo,
            sessionToken: sessionToken,
            version: version,
            error: errorMessage,
          ),
        ) {
    on(_mapEventToState);
  }

  FutureOr<void> _mapEventToState(AppEvent event, Emitter<AppState> emit) {
    switch (event) {
      case AppEventSuccessAppCheck():
        {
          emit(state.copyWith(
            sessionToken: event.appToken,
            version: event.appVersion,
          ));
        }

      case AppEventThrowError():
        {
          emit(state.copyWith(
            error: event.error,
          ));
        }

      case AppEventCleanUp():
        {
          emit(state.copyWith(
            cleanUpFlag: true,
          ));
        }

      case AppEventSetConnectionState():
        {
          emit(state.copyWith(
            connectionFlag: event.connectionState,
          ));
        }
    }
  }

  startSession({
    required String appToken,
    required String appVersion,
  }) {
    add(AppEventSuccessAppCheck(appToken: appToken, appVersion: appVersion));
  }

  throwError(String error) {
    add(AppEventThrowError(error: error));
  }

  logout() {
    add(AppEventCleanUp());
  }

  ///
  /// Services
  ///

  static Services services(BuildContext context) {
    return BlocProvider.of<AppBloc>(context).state.services;
  }
}
