import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Bienvenida extends StatelessWidget {
  const Bienvenida({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUserInfo>(context);
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
        flex: 10,
        child: Center(
            child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: ColorPalette.azul),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: Image.asset(user.avatar).image)))),
      ),
      const Expanded(
          flex: 1,
          child: SizedBox(
            width: 10,
            height: 40,
          )),
      const Expanded(
        flex: 40,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Bienvenido',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                'Da click en el boton de comenzar para empezar tu medición.',
                style: TextStyle(fontSize: 12),
              )
            ]),
      ),
    ]);
  }
}
