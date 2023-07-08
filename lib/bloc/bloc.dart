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
  }) : super(AppState(services: services, error: errorMessage)) {
    _initialize();
  }

  _initialize() {
    on<AppEventSuccessAppCheck>(
      (event, emit) => emit(AppState(
        services: state.services,
        appToken: event.appToken,
        version: event.appVersion,
      )),
    );

    on<AppEventFailedAppCheck>(
      (event, emit) => emit(AppState(
        services: state.services,
        error: event.error,
      )),
    );
  }

  ///
  /// Services
  ///

  static Services services(BuildContext context) {
    return BlocProvider.of<AppBloc>(context).state.services;
  }
}
