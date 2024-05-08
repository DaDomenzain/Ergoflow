import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 40,
        width: 250,
        child: ElevatedButton.icon(
          icon: Icon(
            Icons.logout,
            color: ColorPalette.blanco,
          ),
          label: Text(
            'Cerrar sesión',
            style: TextStyle(color: ColorPalette.blanco),
          ),
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(ColorPalette.gris),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ))),
          onPressed: () {},
        ),
      ),
    );
  }
}
