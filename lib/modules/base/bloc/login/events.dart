///
/// LoginEvent
///

class LoginEvent {}

///
/// LoginOnSuccess
///

class LoginOnSuccess extends LoginEvent {
  final dynamic userData;
  LoginOnSuccess({required this.userData});
}

///
/// LoginOnSuccess
///

class LoginOnFail extends LoginEvent {
  final String message;
  LoginOnFail({required this.message});
}
