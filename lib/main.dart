import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/firebase_options.dart';
import 'package:ergo_flow/logic/auth.dart';
import 'package:ergo_flow/providers/measurement_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:ergo_flow/providers/ble_state.dart';
import 'package:ergo_flow/providers/user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BleState()),
          ChangeNotifierProvider(create: (context) => MyUserInfo()),
          ChangeNotifierProvider(create: (context) => MeasurementState()),
        ],
        child: GetMaterialApp(
            theme: ThemeData(scaffoldBackgroundColor: ColorPalette.blanco),
            debugShowCheckedModeBanner: false,
            home: Center(child: CircularProgressIndicator())));
  }
}
