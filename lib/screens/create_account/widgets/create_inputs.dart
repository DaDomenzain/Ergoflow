import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/auth.dart';
import 'package:ergo_flow/logic/helper_functions.dart';
import 'package:ergo_flow/logic/user.dart';
import 'package:ergo_flow/screens/global_widgets/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ergo_flow/logic/user_repository.dart';

class CreateInputs extends StatefulWidget {
  const CreateInputs({super.key});

  @override
  State<CreateInputs> createState() => _CreateInputsState();
}

class _CreateInputsState extends State<CreateInputs> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  void registerUser() async {
    //Mostrar círculo de carga
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //Confirmar que las contraseñas
    if (passwordController.text != confirmPwController.text) {
      Navigator.pop(context);

      displayMessagetoUser('Contraseñas no conciden', context);
    } else {
      try {
        //Crear usuario
        // ignore: unused_local_variable
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMessagetoUser(e.code, context);
      }
    }

    //Intentar crear usuario
  }

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
          controller: confirmPwController,
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
          onPressed: () async {
            final user = FBUser(
                id: '1234',
                email: emailController.text,
                name: 'Usuario',
                age: 1,
                sex: 'Masculino',
                height: 1,
                weight: 1,
                avatar: 'assets/images/avatar_h_1.jpg');
            await UserRepository().createUser(user);
            AuthenticationRepository.instance.createUserWithEmailandPassword(
                emailController.text, passwordController.text);
          },
        )
      ],
    );
  }
}
