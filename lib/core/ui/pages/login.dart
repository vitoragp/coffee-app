import 'package:coffee_base_app/app_controller/bloc.dart';
import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/core/controllers/login/bloc.dart';
import 'package:coffee_base_app/core/controllers/login/states.dart';
import 'package:coffee_base_app/core/ui/components/input.dart';
import 'package:coffee_base_app/services.dart';
import 'package:coffee_base_app/utils/alert_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// LoginPage
///

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

///
/// _LoginPageState
///

class _LoginPageState extends State<LoginPage> {
  final _bloc = LoginBloc();

  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwCtrl = TextEditingController();

  String? _emailError;
  String? _passwError;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => _bloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginStateSuccess) {
            AppBloc.of(context).loginAndRedirect(context, state.user, AppRoutes.main);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  switch (state) {
                    case LoginStateError(:String message):
                      {
                        AlertUtils.oneButtonsDialog(context: context, message: message);
                      }
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Input(
                      key: const ValueKey("EmailTextField"),
                      controller: _emailCtrl,
                      placeholder: "Email",
                      margin: const EdgeInsets.all(10),
                      error: _emailError,
                    ),
                    Input(
                      key: const ValueKey("PasswordTextField"),
                      controller: _passwCtrl,
                      placeholder: "Senha",
                      margin: const EdgeInsets.all(10),
                      error: _passwError,
                      obscureText: true,
                    ),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) => ElevatedButton(
                        key: const ValueKey("LoginButton"),
                        onPressed: () async {
                          switch (state) {
                            case LoginStateLoading():
                              {}

                            default:
                              {
                                final server = Services.of(context).server;
                                await _bloc.tryLogin(server, _emailCtrl.text, _passwCtrl.text);
                              }
                          }
                        },
                        child: switch (state) {
                          LoginStateLoading() => const Text("Aguarde..."),
                          _ => const Text("Login"),
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pushNamed(AppRoutes.register),
                      child: const Text("Criar nova conta", key: ValueKey("RegisterLink")),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
