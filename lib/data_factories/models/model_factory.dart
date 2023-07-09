import 'package:coffee_base_app/data_factories/models/user.dart';
import 'package:coffee_base_app/models/model.dart';
import 'package:coffee_base_app/models/user.dart';

///
/// ModelFactory
///

class ModelFactory {
  static T? deserialize<T extends Model>(Map<String, dynamic> json) {
    return switch (T) {
      User => deserializeUser(json) as T,
      _ => null,
    };
  }

  static Map<String, dynamic> serialize<T extends Model>(T model) {
    return switch (T) {
      User => serializeUser(model as User),
      _ => {},
    };
  }
}
