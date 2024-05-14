import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/logic/user.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:ergo_flow/screens/global_widgets/my_textfield.dart';
import 'package:ergo_flow/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileInputs extends StatefulWidget {
  const ProfileInputs({super.key});

  @override
  State<ProfileInputs> createState() => _ProfileInputsState();
}

class _ProfileInputsState extends State<ProfileInputs> {
  //Controllers
  String name = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();

  String? selectedSex = '';
  String selectedAvatar = '';
  Color border1 = ColorPalette.blanco;
  Color border2 = ColorPalette.blanco;
  Color border3 = ColorPalette.blanco;

  void editProfile() {}

  Row buildAvatarSelector(String sex) {
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
                setState(() {
                  border1 = ColorPalette.azul;
                  border2 = ColorPalette.blanco;
                  border3 = ColorPalette.blanco;
                  selectedAvatar = 'assets/images/avatar_h_1.jpg';
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
                setState(() {
                  border1 = ColorPalette.blanco;
                  border2 = ColorPalette.azul;
                  border3 = ColorPalette.blanco;
                  selectedAvatar = 'assets/images/avatar_h_2.jpg';
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
                setState(() {
                  border1 = ColorPalette.blanco;
                  border2 = ColorPalette.blanco;
                  border3 = ColorPalette.azul;
                  selectedAvatar = 'assets/images/avatar_h_3.jpg';
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
                BoxDecoration(border: Border.all(color: border1, width: 2)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  border1 = ColorPalette.azul;
                  border2 = ColorPalette.blanco;
                  selectedAvatar = 'assets/images/avatar_m_1.jpg';
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
                BoxDecoration(border: Border.all(color: border2, width: 2)),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  border1 = ColorPalette.blanco;
                  border2 = ColorPalette.azul;
                  selectedAvatar = 'assets/images/avatar_m_2.jpg';
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
            nameController.text = userData.name;
            sexController.text = userData.sex;
            ageController.text = userData.age.toString();
            weightController.text = userData.weight.toString();
            heightController.text = userData.height.toString();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Edita tu perfil',
                  style: TextStyle(
                      color: ColorPalette.azul,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: nameController,
                  hintText: 'Nombre',
                  ispassword: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                DropdownMenu(
                  expandedInsets: const EdgeInsets.all(0),
                  controller: sexController,
                  inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: ColorPalette.gris4,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: ColorPalette.gris4)),
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: ColorPalette.azul)),
                      hintStyle: TextStyle(color: ColorPalette.gris2),
                      labelStyle: TextStyle(color: ColorPalette.azul)),
                  hintText: 'Sexo',
                  label: const Text('Sexo'),
                  menuStyle: MenuStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(ColorPalette.gris4)),
                  dropdownMenuEntries: <DropdownMenuEntry<String>>[
                    DropdownMenuEntry(
                        value: 'M',
                        label: 'Masculino',
                        style: MenuItemButton.styleFrom(
                          textStyle: TextStyle(color: ColorPalette.azul),
                        )),
                    DropdownMenuEntry(
                        value: 'F',
                        label: 'Femenino',
                        style: MenuItemButton.styleFrom(
                          textStyle: TextStyle(color: ColorPalette.azul),
                        ))
                  ],
                  onSelected: (String? sex) {
                    setState(() {
                      selectedSex = sex;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: ageController,
                  hintText: 'Edad',
                  ispassword: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: weightController,
                  hintText: 'Peso en kg',
                  ispassword: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: heightController,
                  hintText: 'Altura en cm',
                  ispassword: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Selecciona un avatar:',
                    style: TextStyle(fontSize: 15)),
                buildAvatarSelector(sexController.text),
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
                    print(selectedAvatar);
                    final newUserData = FBUser(
                        id: userData.id,
                        email: userData.email,
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        sex: sexController.text,
                        height: int.parse(heightController.text),
                        weight: int.parse(weightController.text),
                        avatar: selectedAvatar);
                    userInfo.name = nameController.text;
                    userInfo.avatar = selectedAvatar;
                    await controller.updateRecord(newUserData);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Home()),
                    );
                    ;
                  },
                )
              ],
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
