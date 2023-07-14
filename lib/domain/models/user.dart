import 'package:coffee_base_app/domain/models/model.dart';

///
/// User
///

class User implements Model {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
