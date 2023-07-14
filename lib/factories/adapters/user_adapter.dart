import 'package:coffee_base_app/domain/models/user.dart';

///
/// Serialize user
///

Map<String, dynamic> serializeUser(User userModel) {
  return {
    "id": userModel.id,
    "first_name": userModel.firstName,
    "last_name": userModel.lastName,
    "email": userModel.email,
  };
}

///
/// Deserialize user
///

User deserializeUser(Map<String, dynamic> json) {
  return User(
    id: json["id"] as String,
    firstName: json["first_name"] as String,
    lastName: json["last_name"] as String,
    email: json["email"] as String,
  );
}
