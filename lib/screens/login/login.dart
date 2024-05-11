import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/login/widgets/continue_ext.dart';
import 'package:ergo_flow/screens/login/widgets/inputs.dart';
import 'package:ergo_flow/screens/login/widgets/registrate.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                const Logo(),
                Inputs(),
                const SizedBox(
                  height: 20,
                ),
                const Row(children: <Widget>[
                  Expanded(child: Divider()),
                  SizedBox(
                    width: 20,
                  ),
                  Text("O"),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(child: Divider()),
                ]),
                const SizedBox(
                  height: 20,
                ),
                ContinueExt(),
                const SizedBox(
                  height: 20,
                ),
                Registrate()
              ]),
        ),
      )),
    );
  }
}
