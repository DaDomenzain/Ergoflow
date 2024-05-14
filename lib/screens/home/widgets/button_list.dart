import 'package:flutter/material.dart';

import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/screens/profile_edit/profile_edit.dart';
import 'package:ergo_flow/screens/bluetooth/bluetooth.dart';
import 'package:ergo_flow/screens/history/history.dart';
import 'package:ergo_flow/screens/new_measurement/new_measurement.dart';

class ButtonList extends StatelessWidget {
  const ButtonList({super.key});
  final double buttonheight = 45;
  final double buttonwidth = 175;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(
          height: buttonheight,
          width: buttonwidth,
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.person_outline_rounded,
              color: ColorPalette.blanco,
            ),
            label: Text(
              'Editar perfil',
              style: TextStyle(color: ColorPalette.blanco),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: ColorPalette.azul),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileEdit()),
              );
            },
          ),
        ),
        SizedBox(
          height: buttonheight,
          width: buttonwidth,
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.auto_graph_rounded,
              color: ColorPalette.blanco,
            ),
            label: Text(
              'Nueva medición',
              style: TextStyle(color: ColorPalette.blanco),
            ),
            style:
                ElevatedButton.styleFrom(backgroundColor: ColorPalette.naranja),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewMeasurement()),
              );
            },
          ),
        ),
        SizedBox(
          height: buttonheight,
          width: buttonwidth,
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.history,
              color: ColorPalette.blanco,
            ),
            label: Text(
              'Historial',
              style: TextStyle(color: ColorPalette.blanco),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: ColorPalette.gris),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const History()),
              );
            },
          ),
        ),
        SizedBox(
          height: buttonheight,
          width: buttonwidth,
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.bluetooth_sharp,
              color: ColorPalette.blanco,
            ),
            label: Text(
              'Conectar',
              style: TextStyle(color: ColorPalette.blanco),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: ColorPalette.azul),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Bluetooth()),
              );
            },
          ),
        ),
      ],
    );
  }
}
