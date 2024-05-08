import 'package:ergo_flow/logic/ble_manager.dart';
import 'package:ergo_flow/screens/bluetooth/widgets/avatar.dart';
import 'package:ergo_flow/screens/bluetooth/widgets/calibrate.dart';
import 'package:ergo_flow/screens/bluetooth/widgets/status.dart';
import 'package:ergo_flow/screens/global_widgets/go_back.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';

import 'package:flutter/material.dart';

class Bluetooth extends StatelessWidget {
  const Bluetooth({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const Logo(),
        const GoBack(),
        SizedBox(width: 250, height: 40, child: BleManager()),
        const Status(),
        const SizedBox(width: 250, height: 40, child: Calibrate()),
        const Avatar()
      ],
    )));
  }
}
