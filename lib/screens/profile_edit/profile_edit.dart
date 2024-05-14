import 'package:ergo_flow/screens/global_widgets/go_back.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:ergo_flow/screens/profile_edit/widgets/profile_inputs.dart';
import 'package:flutter/material.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[Logo(), GoBack(), ProfileInputs()],
          ),
        ),
      )),
    );
  }
}
