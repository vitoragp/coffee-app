import 'package:coffee_base_app/types.dart';
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
    required String? errorMessage,
    required String? sessionToken,
    required String? appVersion,
  }) : super(AppState(
          services: services,
          sessionToken: sessionToken,
          version: appVersion,
          error: errorMessage,
        )) {
    _initialize();
  }

  _initialize() {
    on<AppEventSuccessAppCheck>(
      (event, emit) => emit(AppState(
        services: state.services,
        sessionToken: event.appToken,
        version: event.appVersion,
      )),
    );

    on<AppEventHandleError>(
      (event, emit) => emit(AppState(
        services: state.services,
        error: event.error,
      )),
    );

    on<AppEventCleanUp>(
      (event, emit) => emit(AppState(
        services: state.services,
        cleanUpFlag: true,
      )),
    );
  }

  startSession({
    required String appToken,
    required String appVersion,
  }) {
    add(AppEventSuccessAppCheck(appToken: appToken, appVersion: appVersion));
  }

  throwError(String error) {
    add(AppEventHandleError(error: error));
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
