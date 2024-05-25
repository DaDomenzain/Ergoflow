import 'package:ergo_flow/screens/global_widgets/go_back.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/history/widgets/last_measurement.dart';
import 'package:ergo_flow/screens/history/widgets/measurement_history.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Logo(),
              GoBack(),
              LastMeasurement(),
              SizedBox(
                height: 20,
              ),
              MeasurementHistory()
            ],
          ),
        ),
      )),
    );
  }
}
