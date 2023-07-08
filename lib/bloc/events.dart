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
/// AppEventFailedAppCheck
///

class AppEventFailedAppCheck extends AppEvent {
  final String error;
  AppEventFailedAppCheck({required this.error}) : super();
}
