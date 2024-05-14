import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Saludo extends StatelessWidget {
  Saludo({super.key, required this.name});

  String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Hola,',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(name,
              style: TextStyle(
                  color: ColorPalette.naranja,
                  fontSize: 30,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
