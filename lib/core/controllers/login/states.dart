import 'package:coffee_base_app/domain/models/user.dart';

///
/// LoginState
///

class LoginState {}

///
/// LoginStateInitial
///

class LoginStateInitial extends LoginState {}

///
/// LoginStateLoading
///

class LoginStateLoading extends LoginState {}

///
/// LoginStateSuccess
///

class LoginStateSuccess extends LoginState {
  final User user;
  LoginStateSuccess({required this.user});
}

///
/// LoginStateError
///

class LoginStateError extends LoginState {
  final String message;
  LoginStateError({required this.message});
}
