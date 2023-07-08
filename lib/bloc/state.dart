import 'package:coffee_base_app/types.dart';

///
/// AppState
///

class AppState {
  final Services services;
  final String? appToken;
  final String? version;
  final String? error;
  AppState({
    required this.services,
    this.appToken,
    this.version,
    this.error,
  });
}
