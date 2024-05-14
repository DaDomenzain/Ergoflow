import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/login/widgets/continue_ext.dart';
import 'package:ergo_flow/screens/login/widgets/login_inputs.dart';
import 'package:ergo_flow/screens/login/widgets/registrate.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Logo(),
                LoginInputs(),
                SizedBox(
                  height: 20,
                ),
                Row(children: <Widget>[
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
                SizedBox(
                  height: 20,
                ),
                ContinueExt(),
                SizedBox(
                  height: 20,
                ),
                Registrate()
              ]),
        ),
      )),
    );
  }
}
