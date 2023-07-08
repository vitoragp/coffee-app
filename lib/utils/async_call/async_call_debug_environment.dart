///
/// AsyncCallDebugEnvironment
///

class AsyncCallDebugEnvironment {
  static AsyncCallDebugEnvironment? _instance;
  static AsyncCallDebugEnvironment? get instance => _instance;
  static AsyncCallDebugEnvironment? ensureInitialized({required Map<String, dynamic> module}) {
    _instance ??= AsyncCallDebugEnvironment(module: module);
    return _instance;
  }

  final Map<String, dynamic>? _module;
  final String? _activeModuleWithUseCase;

  AsyncCallDebugEnvironment({
    required Map<String, dynamic> module,
    String? activeModuleWithUseCase,
  })  : _module = module,
        _activeModuleWithUseCase = activeModuleWithUseCase;

  bool hasEndpoint(String endpoint) {
    final currentModule = _activeModuleWithUseCase != null ? getMockedModule(_activeModuleWithUseCase!) : _module;
    return currentModule?["data"]?[endpoint] != null;
  }

  Map<String, dynamic>? getEndpoint(String endpoint) {
    final currentModule = _activeModuleWithUseCase != null ? getMockedModule(_activeModuleWithUseCase!) : _module;
    return currentModule?["data"]?[endpoint];
  }

  Map<String, dynamic>? getMockedModule(String moduleWithUseCase) {
    final List<String> path = moduleWithUseCase.split("/");

    dynamic currentNode = _module;
    for (var i = 0; i < path.length; i++) {
      currentNode = currentNode?[path[i]];
    }
    return currentNode;
  }
}
