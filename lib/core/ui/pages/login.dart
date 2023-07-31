import 'package:coffee_base_app/app_controller/bloc.dart';
import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/core/controllers/login/bloc.dart';
import 'package:coffee_base_app/core/controllers/login/states.dart';
import 'package:coffee_base_app/core/ui/components/button.dart';
import 'package:coffee_base_app/core/ui/components/input.dart';
import 'package:coffee_base_app/core/ui/pages/components/cloud_banner.dart';
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return BlocProvider<LoginBloc>(
      create: (context) => _bloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginStateSuccess) {
            AppBloc.of(context).loginAndRedirect(context, state.user, AppRoutes.main);
          }
          if (state is LoginStateError) {
            AlertUtils.oneButtonsDialog(context: context, message: state.message);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.yellowL1,
          body: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(width: width, height: height, child: _buildLayout(context)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLayout(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildFormLayer(context),
          _buildRegisterLayer(context),
        ],
      );

  Widget _buildRegisterLayer(BuildContext context) => Center(
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.register);
          },
          child: const Text(
            "Criar nova conta",
            style: TextStyle(color: AppColors.orangeDark),
            key: ValueKey("RegisterLink"),
          ),
        ),
      );

  Widget _buildFormLayer(BuildContext context) => Expanded(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildLoginForm(),
            ),
          ),
        ),
      );

  List<Widget> _buildLoginForm() => [
        _buildTitle(),
        _buildInput("EmailTextField", "Email", _emailError, _emailCtrl),
        _buildObscureInput("PasswordTextField", "Senha", _passwError, _passwCtrl),
        _buildForgotPassword(context),
        _buildButton(),
      ];

  Widget _buildTitle() => const Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: CloudBanner(
          title: "Bem vindo!",
          subtitle: "Você pode entrar na sua conta\nusando seu email e senha!",
        ),
      );

  Widget _buildInput(
    String name,
    String label,
    String? error,
    TextEditingController controller,
  ) =>
      Input(
        key: ValueKey(name),
        controller: controller,
        placeholder: label,
        margin: const EdgeInsets.all(10),
        error: error,
        obscureText: false,
      );

  Widget _buildObscureInput(
    String name,
    String label,
    String? error,
    TextEditingController controller,
  ) =>
      Input(
        key: ValueKey(name),
        controller: _passwCtrl,
        placeholder: label,
        margin: const EdgeInsets.all(10),
        error: error,
        obscureText: true,
      );

  Widget _buildForgotPassword(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            key: const ValueKey("ForgotPasswordLink"),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
            },
            child: const Text(
              "Esqueceu sua senha?",
              textAlign: TextAlign.end,
              style: TextStyle(color: AppColors.orangeDark),
            ),
          ),
        ),
      );

  Widget _buildButton() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Button(
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
            label: switch (state) {
              LoginStateLoading() => "Aguarde...",
              _ => "Login",
            },
          ),
        ),
      );
}
