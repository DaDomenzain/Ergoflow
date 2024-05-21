import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContinueExt extends StatelessWidget {
  const ContinueExt({super.key});

  @override
  Widget build(BuildContext context) {
    final isGoogleLoading = false.obs;

    Future<void> googleSignIn() async {
      try {
        isGoogleLoading.value = true;
        await AuthenticationRepository.instance.signInWithGoogle();
        isGoogleLoading.value = false;
      } catch (e) {
        isGoogleLoading.value = false;
        Get.snackbar('Error', e.toString());
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ElevatedButton.icon(
          icon: Icon(
            Icons.g_mobiledata_rounded,
            color: ColorPalette.azul,
          ),
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll<double>(0),
              backgroundColor:
                  MaterialStatePropertyAll<Color>(ColorPalette.blanco),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: ColorPalette.gris3, width: 2)))),
          label: Text('Continua con Google',
              style: TextStyle(color: ColorPalette.azul, fontSize: 17)),
          onPressed: () {
            googleSignIn();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton.icon(
          icon: Icon(
            Icons.apple,
            color: ColorPalette.azul,
          ),
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll<double>(0),
              backgroundColor:
                  MaterialStatePropertyAll<Color>(ColorPalette.blanco),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: ColorPalette.gris3, width: 2)))),
          label: Text(
            'Continua con Apple',
            style: TextStyle(color: ColorPalette.azul, fontSize: 17),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
