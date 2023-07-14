import 'events.dart';
import 'states.dart';
import 'package:bloc/bloc.dart';

///
/// RegisterBloc
///

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterState());
}
