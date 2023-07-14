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
/// AppEventCleanUp
///

final class AppEventCleanUp extends AppEvent {}

///
/// AppEventSetConnectionState
///
///

final class AppEventSetConnectionState extends AppEvent {
  final bool connectionState;
  AppEventSetConnectionState({required this.connectionState});
}
