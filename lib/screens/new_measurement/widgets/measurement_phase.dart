import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/providers/ble_state.dart';
import 'package:ergo_flow/providers/measurement_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MeasurementTimes extends StatefulWidget {
  double time;
  MeasurementTimes({super.key, required this.time});

  @override
  State<MeasurementTimes> createState() => _MeasurementTimesState();
}

ElevatedButton createButton(BuildContext context, String buttonText) {
  final measurementState = Provider.of<MeasurementState>(context);
  final bleState = Provider.of<BleState>(context);
  ElevatedButton button = ElevatedButton(
      onPressed: null,
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 12),
      ));
  if (bleState.notifyState) {
    button = ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorPalette.azul,
        ),
        child: Text(buttonText,
            style: TextStyle(color: ColorPalette.blanco, fontSize: 12)),
        onPressed: () {
          measurementState.excercise = true;
          measurementState.rest = true;
        });
  }
  return button;
}

class _MeasurementTimesState extends State<MeasurementTimes> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        createButton(context, 'Empezar ejercicio'),
        const SizedBox(
          width: 10,
        ),
        createButton(context, 'Empezar recuperación')
      ],
    );
  }
}
