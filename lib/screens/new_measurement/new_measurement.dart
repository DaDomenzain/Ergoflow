import 'package:ergo_flow/logic/receive_data_manager.dart';
import 'package:ergo_flow/screens/global_widgets/go_back.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/new_measurement/widgets/bienvenida.dart';
import 'package:ergo_flow/screens/new_measurement/widgets/comparar.dart';
import 'package:flutter/material.dart';

class NewMeasurement extends StatelessWidget {
  const NewMeasurement({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Logo(),
        GoBack(),
        Bienvenida(),
        SizedBox(
          height: 30,
        ),
        ReceiveData(),
        Comparar()
      ]),
    )));
  }
}
