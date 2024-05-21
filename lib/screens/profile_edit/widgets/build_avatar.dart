import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/logic/user.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:ergo_flow/screens/home/home.dart';
import 'package:ergo_flow/screens/profile_edit/widgets/avatar_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BuildAvatarGridView extends StatefulWidget {
  BuildAvatarGridView({super.key});
  String selectedAvatar = '';

  @override
  State<BuildAvatarGridView> createState() => _BuildAvatarState();
}

class _BuildAvatarState extends State<BuildAvatarGridView> {
  List<Map<String, dynamic>> items = <Map<String, dynamic>>[
    <String, dynamic>{'path': 'assets/images/1.jpg'},
    <String, dynamic>{'path': 'assets/images/2.jpg'},
    <String, dynamic>{'path': 'assets/images/3.jpg'},
    <String, dynamic>{'path': 'assets/images/4.jpg'},
    <String, dynamic>{'path': 'assets/images/5.jpg'},
    <String, dynamic>{'path': 'assets/images/6.jpg'},
    <String, dynamic>{'path': 'assets/images/7.jpg'},
    <String, dynamic>{'path': 'assets/images/8.jpg'},
    <String, dynamic>{'path': 'assets/images/9.jpg'},
    <String, dynamic>{'path': 'assets/images/10.jpg'},
    <String, dynamic>{'path': 'assets/images/11.jpg'},
    <String, dynamic>{'path': 'assets/images/12.jpg'},
    <String, dynamic>{'path': 'assets/images/13.jpg'},
    <String, dynamic>{'path': 'assets/images/14.jpg'},
  ];

  int optionSelected = 1;
  void checkOption(int index) {
    setState(() {
      optionSelected = index;
      widget.selectedAvatar = 'assets/images/$optionSelected.jpg';
      print(widget.selectedAvatar);
    });
  }

  GridView buildGridView() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        for (var i = 0; i < items.length; i++)
          AvatarView(
              path: items[i]['path'] as String,
              onTap: () => checkOption(i + 1),
              selected: i + 1 == optionSelected)
      ],
    );
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
              buildGridView(),
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
                  //print(widget.selectedAvatar);
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
