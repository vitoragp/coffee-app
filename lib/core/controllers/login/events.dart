import 'package:coffee_base_app/domain/models/user.dart';

///
/// LoginEvent
///

sealed class LoginEvent {}

///
/// LoginEventLoading
///

class LoginEventLoading extends LoginEvent {}

///
/// LoginEventSuccess
///

class LoginEventSuccess extends LoginEvent {
  final User user;
  LoginEventSuccess({required this.user});
}

///
/// LoginEventError
///

class LoginEventError extends LoginEvent {
  final String message;
  LoginEventError({required this.message});
}
