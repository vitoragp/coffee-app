import 'package:coffee_base_app/types.dart';
import 'package:coffee_base_app/utils/platform.dart';

///
/// AppState
///

class AppState {
  final Services services;
  final DeviceInfo deviceInfo;
  final String? sessionToken;
  final String? version;
  final String? error;
  final bool cleanUpFlag;
  final bool connectionFlag;

  AppState({
    required this.services,
    required this.deviceInfo,
    this.sessionToken,
    this.version,
    this.error,
    this.cleanUpFlag = false,
    this.connectionFlag = true,
  });

  AppState copyWith({
    final Services? services,
    final DeviceInfo? deviceInfo,
    final String? sessionToken,
    final String? version,
    final String? error,
    final bool? cleanUpFlag,
    final bool? connectionFlag,
  }) {
    return AppState(
      services: services ?? this.services,
      deviceInfo: deviceInfo ?? this.deviceInfo,
      sessionToken: sessionToken ?? this.sessionToken,
      version: version ?? this.version,
      error: error ?? this.error,
      cleanUpFlag: cleanUpFlag ?? this.cleanUpFlag,
      connectionFlag: connectionFlag ?? this.connectionFlag,
    );
  }
}
