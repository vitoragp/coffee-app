import 'package:coffee_base_app/bloc/bloc.dart';
import 'package:flutter/material.dart';

///
/// MainPage
///

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBloc.services(context).server;

    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Main page"),
        ),
      ),
    );
  }
}
