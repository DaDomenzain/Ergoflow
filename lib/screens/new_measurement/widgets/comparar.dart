import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

class Comparar extends StatelessWidget {
  const Comparar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Para comparar con la última medición da click en el botón:',
            style: TextStyle(fontSize: 12),
          ),
          ElevatedButton(
            style:
                ElevatedButton.styleFrom(backgroundColor: ColorPalette.naranja),
            child: Text(
              'Comparar',
              style: TextStyle(color: ColorPalette.blanco),
            ),
            onPressed: () {},
          )
        ]);
  }
}
