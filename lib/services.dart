import 'package:coffee_base_app/utils/server.dart';
import 'package:coffee_base_app/utils/storage.dart';
import 'package:flutter/material.dart';

///
/// Services
///

class Services {
  final Server server;
  final Storage storage;

  const Services({
    required this.server,
    required this.storage,
  });

  static Services of(BuildContext context) {
    return context.getInheritedWidgetOfExactType<ServicesInheritedWidget>()!.services;
  }
}

///
/// ServicesInheritedWidget
///

class ServicesInheritedWidget extends InheritedWidget {
  final Services services;

  const ServicesInheritedWidget({
    required Widget child,
    required this.services,
  }) : super(key: const ValueKey("Services"), child: child);

  @override
  bool updateShouldNotify(covariant ServicesInheritedWidget oldWidget) {
    return services != oldWidget.services;
  }
}
