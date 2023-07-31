///
/// AsyncCallDebugEnvironment
///

class AsyncCallDebugEnvironment {
  final Map<String, dynamic>? _module;
  final String? _activeModuleWithUseCase;
  final Map<String, dynamic>? _specificUseCases;

  AsyncCallDebugEnvironment({
    required Map<String, dynamic> module,
    String? activeModuleWithUseCase,
    Map<String, dynamic>? specificUseCases,
  })  : _module = module,
        _activeModuleWithUseCase = activeModuleWithUseCase,
        _specificUseCases = specificUseCases;

  bool hasEndpoint(String endpoint) {
    if (_specificUseCases != null && _specificUseCases!.keys.contains(endpoint)) {
      final currentModule = getMockedModule(_specificUseCases![endpoint]);
      return currentModule?["data"]?[endpoint] != null;
    }
    final currentModule = _activeModuleWithUseCase != null ? getMockedModule(_activeModuleWithUseCase!) : _module;
    return currentModule?["data"]?[endpoint] != null;
  }

  Map<String, dynamic>? getEndpoint(String endpoint) {
    if (_specificUseCases != null && _specificUseCases!.keys.contains(endpoint)) {
      final currentModule = getMockedModule(_specificUseCases![endpoint]);
      return currentModule?["data"]?[endpoint];
    }
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
