import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/screens/login/login.dart';
import 'package:flutter/material.dart';

class Access extends StatelessWidget {
  const Access({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text('¿Ya tienes una cuenta?'),
        TextButton(
          style: TextButton.styleFrom(padding: const EdgeInsets.all(5)),
          child: Text(
            'Accede aquí',
            style: TextStyle(color: ColorPalette.naranja),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
        )
      ],
    );
  }
}
