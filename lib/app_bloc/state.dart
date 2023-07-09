import 'package:coffee_base_app/types.dart';

///
/// AppState
///

class AppState {
  final Services services;
  final String? sessionToken;
  final String? version;
  final String? error;
  final bool cleanUpFlag;
  AppState({
    required this.services,
    this.sessionToken,
    this.version,
    this.error,
    this.cleanUpFlag = false,
  });
}
