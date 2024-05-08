import 'package:ergo_flow/screens/home/widgets/avatar.dart';
import 'package:ergo_flow/screens/home/widgets/button_list.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/home/widgets/logout.dart';
import 'package:ergo_flow/screens/home/widgets/saludo.dart';

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        child: Column(children: <Widget>[
          Expanded(flex: 4, child: Logo()),
          Expanded(flex: 2, child: Saludo()),
          Divider(),
          Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[ButtonList(), Avatar()],
                ),
              )),
          Expanded(flex: 3, child: Logout())
        ]),
      ),
    ));
  }
}
