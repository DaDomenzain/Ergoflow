import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/providers/user_info.dart';

import 'package:ergo_flow/screens/home/widgets/avatar.dart';
import 'package:ergo_flow/screens/home/widgets/button_list.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/home/widgets/logout.dart';
import 'package:ergo_flow/screens/home/widgets/saludo.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final userInfo = Provider.of<MyUserInfo>(context);

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                //FBUser userData = snapshot.data as FBUser;
                return Column(children: <Widget>[
                  const Expanded(flex: 4, child: Logo()),
                  Expanded(flex: 2, child: Saludo(name: userInfo.name)),
                  const Divider(),
                  const Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[ButtonList(), Avatar()],
                        ),
                      )),
                  const Expanded(flex: 3, child: Logout())
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
        ),
      ),
    ));
  }
}
