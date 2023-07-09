import 'package:coffee_base_app/models/user.dart';

///
/// Model
///

abstract interface class Model {
  static T serialize<T extends Model>(Map<String, dynamic> json) {
    switch (T) {
      case User:
        {
          return User(
            id: json["id"] as String,
            firstName: json["first_name"] as String,
            lastName: json["last_name"] as String,
            email: json["email"] as String,
          ) as T;
        }
    }
    throw UnimplementedError();
  }

  static Map<String, dynamic> deserialize<T extends Model>(T model) {
    switch (T) {
      case User:
        {
          final user = model as User;
          Map<String, dynamic> json = {
            "id": user.id,
            "first_name": user.firstName,
            "last_name": user.lastName,
            "email": user.email,
          };
          return json;
        }
    }
    throw UnimplementedError();
  }
}
