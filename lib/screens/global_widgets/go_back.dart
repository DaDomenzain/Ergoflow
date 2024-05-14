import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  const GoBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: TextButton.icon(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: ColorPalette.naranja,
          ),
          label: Text('Atrás', style: TextStyle(color: ColorPalette.negro)),
          style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
          onPressed: () {
            Navigator.pop(context);
          }),
    );
  }
}
