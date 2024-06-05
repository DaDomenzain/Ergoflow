import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/logic/user.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:ergo_flow/screens/home/home.dart';
import 'package:ergo_flow/screens/profile_edit/profile_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final userInfo = Provider.of<MyUserInfo>(context);
    return FutureBuilder(
      future: controller.getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            FBUser userData = snapshot.data as FBUser;
            return SafeArea(
              child: Scaffold(
                backgroundColor: ColorPalette.azul,
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: SizedBox(
                            height: 125,
                            width: 350,
                            child: Image.asset(
                              'assets/images/logo_splash.png',
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.naranja),
                            child: Text(
                              'Edita tu perfil',
                              style: TextStyle(
                                color: ColorPalette.blanco,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              userInfo.age = userData.age;
                              userInfo.id = userData.id;
                              userInfo.email = userData.email;
                              userInfo.weight = userData.weight;
                              userInfo.height = userData.height;
                              userInfo.sex = userData.sex;
                              userInfo.name = userData.name;
                              userInfo.avatar = userData.avatar;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfileEdit()),
                              );
                            },
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorPalette.gris),
                            child: Text(
                              'Comienza a medir',
                              style: TextStyle(color: ColorPalette.blanco),
                            ),
                            onPressed: () {
                              userInfo.age = userData.age;
                              userInfo.id = userData.id;
                              userInfo.email = userData.email;
                              userInfo.weight = userData.weight;
                              userInfo.height = userData.height;
                              userInfo.sex = userData.sex;
                              userInfo.name = userData.name;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            },
                          ),
                        ],
                      )
                    ]),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
