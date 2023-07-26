import 'package:coffee_base_app/domain/models/user.dart';
import 'package:coffee_base_app/utils/platform.dart';

///
/// AppState
///

class AppState {
  final DeviceInfo deviceInfo;
  final User? user;
  final String? sessionToken;
  final String? version;
  final String? error;
  final bool cleanUpFlag;
  final bool connectionFlag;

  AppState({
    required this.deviceInfo,
    this.user,
    this.sessionToken,
    this.version,
    this.error,
    this.cleanUpFlag = false,
    this.connectionFlag = true,
  });

  AppState copyWith({
    final DeviceInfo? deviceInfo,
    final User? user,
    final String? sessionToken,
    final String? version,
    final String? error,
    final bool? cleanUpFlag,
    final bool? connectionFlag,
  }) {
    return AppState(
      deviceInfo: deviceInfo ?? this.deviceInfo,
      user: user ?? this.user,
      sessionToken: sessionToken ?? this.sessionToken,
      version: version ?? this.version,
      error: error ?? this.error,
      cleanUpFlag: cleanUpFlag ?? this.cleanUpFlag,
      connectionFlag: connectionFlag ?? this.connectionFlag,
    );
  }
}
