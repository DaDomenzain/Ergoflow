import 'package:ergo_flow/screens/global_widgets/go_back.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/profile_edit/widgets/build_avatar.dart';
import 'package:flutter/material.dart';

class AvatarSelect extends StatelessWidget {
  const AvatarSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[const Logo(), const GoBack(), BuildAvatar()],
          ),
        ),
      )),
    );
  }
}
