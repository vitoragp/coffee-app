import 'package:coffee_base_app/app_controller/bloc.dart';
import 'package:coffee_base_app/constants.dart';
import 'package:coffee_base_app/utils/alert_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///
/// MainPage
///

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppBloc.of(context, listen: false).state;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(state.user!.firstName),
              Text(state.sessionToken!),
              Text(state.version!),
              ElevatedButton(
                onPressed: () {
                  AlertUtils.twoButtonsDialog(
                    context: context,
                    title: "App",
                    message: "Deseja sair?",
                    onPositiveClick: () {
                      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                        AppBloc.of(context).logoutAndRedirect(context, AppRoutes.login);
                      });
                    },
                  );
                },
                child: const Text("Logout"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
