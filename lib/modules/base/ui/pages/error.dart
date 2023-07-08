import 'package:coffee_base_app/bloc/bloc.dart';
import 'package:coffee_base_app/bloc/events.dart';
import 'package:coffee_base_app/bloc/state.dart';
import 'package:coffee_base_app/types.dart';
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
                      doAppCheckAndUpdateTokenAndVersion(
                        context,
                        state.services,
                      );
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

  doAppCheckAndUpdateTokenAndVersion(
    BuildContext context,
    Services services,
  ) async {
    final bloc = BlocProvider.of<AppBloc>(context);
    switch (await services.server.appCheck("")) {
      case {"http_success": true, "body": Map body}:
        {
          bloc.add(AppEventSuccessAppCheck(
            appToken: body["session_token"] as String,
            appVersion: body["version"] as String,
          ));
        }
      case {"http_success": false, "body": Map body}:
        {
          bloc.add(AppEventFailedAppCheck(
            error: body["message"] as String,
          ));
        }
    }
  }
}
