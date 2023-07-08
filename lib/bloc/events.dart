///
/// AppEvent
///

class AppEvent {}

///
/// AppEventInitialize
///

class AppEventInitialize extends AppEvent {
  final String appToken;
  final String version;
  AppEventInitialize({
    required this.appToken,
    required this.version,
  }) : super();
}

///
/// AppEventFailedToInitialize
///

class AppEventFailedToInitialize extends AppEvent {
  final String error;
  AppEventFailedToInitialize({required this.error});
}
