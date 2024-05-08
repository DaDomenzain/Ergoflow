import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

class Calibrate extends StatelessWidget {
  const Calibrate({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStatePropertyAll<Color>(ColorPalette.naranja),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ))),
      child: Text('Calibración', style: TextStyle(color: ColorPalette.blanco)),
      onPressed: () {},
    );
  }
}
