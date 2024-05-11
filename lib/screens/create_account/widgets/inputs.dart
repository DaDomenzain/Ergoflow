import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/screens/global_widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class Inputs extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Inputs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Crea tu cuenta',
          style: TextStyle(
              fontSize: 30,
              color: ColorPalette.azul,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Completa la siguiente información',
          style: TextStyle(fontSize: 15, color: ColorPalette.negro),
        ),
        const SizedBox(
          height: 20,
        ),
        MyTextField(
          controller: emailController,
          hintText: 'Correo',
          ispassword: false,
        ),
        const SizedBox(
          height: 20,
        ),
        MyTextField(
          controller: passwordController,
          hintText: 'Contraseña',
          ispassword: true,
        ),
        const SizedBox(
          height: 20,
        ),
        MyTextField(
          controller: passwordController,
          hintText: 'Confirme contraseña',
          ispassword: true,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(ColorPalette.azul),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ))),
          child: Text(
            'Crea cuenta',
            style: TextStyle(color: ColorPalette.blanco, fontSize: 17),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
