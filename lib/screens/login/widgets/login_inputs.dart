import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/auth.dart';
import 'package:ergo_flow/logic/helper_functions.dart';
import 'package:ergo_flow/screens/global_widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginInputs extends StatefulWidget {
  const LoginInputs({super.key});

  @override
  State<LoginInputs> createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    //Mostrar círculo de carga
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //Intentar iniciar sesión
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
        displayMessagetoUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          '¡Bienvenido!',
          style: TextStyle(
              fontSize: 30,
              color: ColorPalette.azul,
              fontWeight: FontWeight.bold),
        ),
        Text(
          'Inicia sesión para empezar tus mediciones',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
              child: Text('¿Olvidaste tu contraseña?',
                  style: TextStyle(color: ColorPalette.gris3, fontSize: 13)),
              onPressed: () {},
            ),
          ],
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
            'Acceder',
            style: TextStyle(color: ColorPalette.blanco, fontSize: 17),
          ),
          onPressed: () {
            AuthenticationRepository.instance.loginWithEmailandPassword(
                emailController.text, passwordController.text);
          },
        )
      ],
    );
  }
}
