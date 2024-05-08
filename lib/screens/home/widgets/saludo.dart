import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Saludo extends StatelessWidget {
  const Saludo({super.key});

  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Hola,',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(userInfo.name,
              style: TextStyle(
                  color: ColorPalette.naranja,
                  fontSize: 30,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
