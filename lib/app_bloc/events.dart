///
/// AppEvent
///

class AppEvent {}

///
/// AppEventSuccessAppCheck
///

class AppEventSuccessAppCheck extends AppEvent {
  final String appToken;
  final String appVersion;
  AppEventSuccessAppCheck({
    required this.appToken,
    required this.appVersion,
  }) : super();
}

///
/// AppEventHandleError
///

class AppEventHandleError extends AppEvent {
  final String error;
  AppEventHandleError({required this.error}) : super();
}

///
/// AppEventCleanUp
///

class AppEventCleanUp extends AppEvent {}
