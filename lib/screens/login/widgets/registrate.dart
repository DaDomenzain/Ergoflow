import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/screens/create_account/create_account.dart';
import 'package:flutter/material.dart';

class Registrate extends StatelessWidget {
  const Registrate({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('¿No tienes una cuenta?'),
        TextButton(
          style: TextButton.styleFrom(padding: const EdgeInsets.all(5)),
          child: Text(
            'Regístrate aquí',
            style: TextStyle(color: ColorPalette.naranja),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateAccount()),
            );
          },
        )
      ],
    );
  }
}
