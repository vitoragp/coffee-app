import 'package:coffee_base_app/app_controller/bloc.dart';
import 'package:coffee_base_app/app_controller/state.dart';
import 'package:coffee_base_app/services.dart';
import 'package:coffee_base_app/utils/server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// ErrorPage
///

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ErrorPageState();
  }
}

///
/// _ErrorPageState
///

class _ErrorPageState extends State<ErrorPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.error!),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      doAppCheck(context, Services.of(context).server);
                    },
                    child: const Text("Tentar novamente"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  doAppCheck(
    BuildContext context,
    Server server,
  ) async {
    final bloc = BlocProvider.of<AppBloc>(context);
    switch (await server.appCheck()) {
      case {"http_success": true, "body": Map body}:
        {
          bloc.startSession(
            context,
            appToken: body["session_token"] as String,
            appVersion: body["version"] as String,
          );
        }
      case {"http_success": false, "body": Map body}:
        {
          bloc.throwError(
            body["message"] as String,
          );
        }
    }
  }
}
