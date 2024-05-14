import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/create_account/widgets/continue_ext.dart';
import 'package:ergo_flow/screens/create_account/widgets/create_inputs.dart';
import 'package:ergo_flow/screens/create_account/widgets/access.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

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
                CreateInputs(),
                SizedBox(
                  height: 10,
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
                  height: 10,
                ),
                ContinueExt(),
                Access()
              ]),
        ),
      )),
    );
  }
}
