import 'package:ergo_flow/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInfo>(context);
    return Center(
      child: Container(
        width: 175,
        height: 175,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(fit: BoxFit.fill, image: user.avatar.image)),
        //child: Image.asset('assets/images/avatar1.jpg'),
      ),
    );
  }
}
