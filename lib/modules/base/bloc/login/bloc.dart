import 'events.dart';
import 'states.dart';
import 'package:bloc/bloc.dart';

///
/// LoginBloc
///

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {}
}
