import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

class LastMeasurement extends StatelessWidget {
  const LastMeasurement({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: ColorPalette.blanco,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.gris2,
            spreadRadius: 0.5,
            blurRadius: 3,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Text('Última medición'),
    );
  }
}
