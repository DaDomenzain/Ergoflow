import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          height: 125,
          width: 250,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.cover,
          )),
    );
  }
}
