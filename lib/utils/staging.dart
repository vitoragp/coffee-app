import 'package:flutter/foundation.dart';

///
/// Types
///

typedef StagingCallback = void Function(Map<String, dynamic>);

///
/// Staging
///

class Staging {
  static final Map<String, dynamic> _stagingDataMap = {};
  static runInDebug(StagingCallback callback) {
    if (kDebugMode) {
      callback(_stagingDataMap);
    }
  }
}
