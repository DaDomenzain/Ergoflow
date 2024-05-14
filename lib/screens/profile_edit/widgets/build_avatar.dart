import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/logic/user.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:ergo_flow/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BuildAvatar extends StatefulWidget {
  BuildAvatar({super.key});
  String selectedAvatar = '';

  @override
  State<BuildAvatar> createState() => _BuildAvatarState();
}

class _BuildAvatarState extends State<BuildAvatar> {
  Color border1 = ColorPalette.blanco;
  Color border2 = ColorPalette.blanco;
  Color border3 = ColorPalette.blanco;
  Color border4 = ColorPalette.blanco;
  Color border5 = ColorPalette.blanco;

  Row buildAvatarSelector(BuildContext context, String sex) {
    final userInfo = Provider.of<MyUserInfo>(context);
    Row avatarRow;

    if (sex == 'Masculino') {
      avatarRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: border1, width: 2)),
            child: GestureDetector(
              onTap: () {
                userInfo.avatar = 'assets/images/avatar_h_1.jpg';
                setState(() {
                  border1 = ColorPalette.azul;
                  border2 = ColorPalette.blanco;
                  border3 = ColorPalette.blanco;
                  border4 = ColorPalette.blanco;
                  border5 = ColorPalette.blanco;
                  widget.selectedAvatar = 'assets/images/avatar_h_1.jpg';
                });
              }, // Image tapped
              child: Image.asset(
                'assets/images/avatar_h_1.jpg',
                fit: BoxFit.cover, // Fixes border issues
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: border2, width: 2)),
            child: GestureDetector(
              onTap: () {
                userInfo.avatar = 'assets/images/avatar_h_2.jpg';
                setState(() {
                  border1 = ColorPalette.blanco;
                  border2 = ColorPalette.azul;
                  border3 = ColorPalette.blanco;
                  border4 = ColorPalette.blanco;
                  border5 = ColorPalette.blanco;
                  widget.selectedAvatar = 'assets/images/avatar_h_2.jpg';
                });
              }, // Image tapped
              child: Image.asset(
                'assets/images/avatar_h_2.jpg',
                fit: BoxFit.cover, // Fixes border issues
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: border3, width: 2)),
            child: GestureDetector(
              onTap: () {
                userInfo.avatar = 'assets/images/avatar_h_3.jpg';
                setState(() {
                  border1 = ColorPalette.blanco;
                  border2 = ColorPalette.blanco;
                  border3 = ColorPalette.azul;
                  border4 = ColorPalette.blanco;
                  border5 = ColorPalette.blanco;
                  widget.selectedAvatar = 'assets/images/avatar_h_3.jpg';
                });
              }, // Image tapped
              child: Image.asset(
                'assets/images/avatar_h_3.jpg',
                fit: BoxFit.cover, // Fixes border issues
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
        ],
      );
    } else {
      avatarRow = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: border4, width: 2)),
            child: GestureDetector(
              onTap: () {
                userInfo.avatar = 'assets/images/avatar_m_1.jpg';
                setState(() {
                  border1 = ColorPalette.blanco;
                  border2 = ColorPalette.blanco;
                  border3 = ColorPalette.blanco;
                  border4 = ColorPalette.azul;
                  border5 = ColorPalette.blanco;
                  widget.selectedAvatar = 'assets/images/avatar_m_1.jpg';
                });
              }, // Image tapped
              child: Image.asset(
                'assets/images/avatar_m_1.jpg',
                fit: BoxFit.cover, // Fixes border issues
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: border5, width: 2)),
            child: GestureDetector(
              onTap: () {
                userInfo.avatar = 'assets/images/avatar_m_2.jpg';
                setState(() {
                  border1 = ColorPalette.blanco;
                  border2 = ColorPalette.blanco;
                  border3 = ColorPalette.blanco;
                  border4 = ColorPalette.blanco;
                  border5 = ColorPalette.azul;
                  widget.selectedAvatar = 'assets/images/avatar_m_2.jpg';
                });
              }, // Image tapped
              child: Image.asset(
                'assets/images/avatar_m_2.jpg',
                fit: BoxFit.cover, // Fixes border issues
                width: 100.0,
                height: 100.0,
              ),
            ),
          ),
        ],
      );
    }
    return avatarRow;
  }

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

            return Column(children: [
              const SizedBox(
                height: 10,
              ),
              const Text('Selecciona un avatar:',
                  style: TextStyle(fontSize: 15)),
              buildAvatarSelector(context, 'Masculino'),
              buildAvatarSelector(context, 'Femenino'),
              const SizedBox(
                height: 10,
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
                  'Guardar cambios',
                  style: TextStyle(color: ColorPalette.blanco, fontSize: 17),
                ),
                onPressed: () async {
                  final newUserData = FBUser(
                      id: userData.id,
                      email: userData.email,
                      name: userData.name,
                      age: userData.age,
                      sex: userData.sex,
                      height: userData.height,
                      weight: userData.weight,
                      avatar: widget.selectedAvatar);

                  userInfo.avatar = widget.selectedAvatar;
                  await controller.updateRecord(newUserData);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              )
            ]);
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
