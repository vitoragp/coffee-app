import 'package:coffee_base_app/models/user.dart';

///
/// Model
///

abstract interface class Model {
  static T serialize<T extends Model>(Map<String, dynamic> json) {
    switch (T) {
      case User:
        {
          var user = User();
          return user as T;
        }
    }
    throw UnimplementedError();
  }

  static Map<String, dynamic> deserialize<T extends Model>(T model) {
    switch (T) {
      case User:
        {
          Map<String, dynamic> json = {};
          return json;
        }
    }
    throw UnimplementedError();
  }
}
