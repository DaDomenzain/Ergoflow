import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/providers/ble_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Status extends StatefulWidget {
  const Status({super.key});

  @override
  State<Status> createState() => _StatusState();
}

class _StatusState extends State<Status> {
  @override
  Widget build(BuildContext context) {
    final bleState = Provider.of<BleState>(context);

    (String, Color) setStatus(bool status) {
      String finalStatus;
      Color color;
      if (status) {
        finalStatus = 'Conectado';
        color = Colors.greenAccent;
      } else {
        finalStatus = 'Desconectado';
        color = Colors.redAccent;
      }
      return (finalStatus, color);
    }

    var (status, color) = setStatus(bleState.connectionState);
    return RichText(
        text: TextSpan(children: <TextSpan>[
      TextSpan(text: 'Estatus: ', style: TextStyle(color: ColorPalette.negro)),
      TextSpan(text: status, style: TextStyle(color: color))
    ]));
  }
}
