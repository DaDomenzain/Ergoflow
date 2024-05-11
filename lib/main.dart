import 'package:ergo_flow/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ergo_flow/providers/ble_state.dart';
import 'package:ergo_flow/providers/user_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => BleState()),
          ChangeNotifierProvider(create: (context) => UserInfo()),
        ],
        child: const MaterialApp(
            debugShowCheckedModeBanner: false, home: Login()));
  }
}
