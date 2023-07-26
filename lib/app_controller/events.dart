import 'package:coffee_base_app/domain/models/user.dart';

///
/// AppEvent
///

sealed class AppEvent {}

///
/// AppEventSuccessAppCheck
///

final class AppEventSuccessAppCheck extends AppEvent {
  final String appToken;
  final String appVersion;
  AppEventSuccessAppCheck({
    required this.appToken,
    required this.appVersion,
  }) : super();
}

///
/// AppEventThrowError
///

final class AppEventThrowError extends AppEvent {
  final String error;
  AppEventThrowError({required this.error}) : super();
}

///
/// AppEventLogin
///

final class AppEventLogin extends AppEvent {
  final User user;
  AppEventLogin({required this.user});
}

///
/// AppEventLogout
///

final class AppEventLogout extends AppEvent {}

///
/// AppEventSetConnectionState
///
///

final class AppEventSetConnectionState extends AppEvent {
  final bool connectionState;
  AppEventSetConnectionState({required this.connectionState});
}
