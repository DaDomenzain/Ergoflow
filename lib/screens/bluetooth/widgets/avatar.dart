import 'package:ergo_flow/providers/user_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInfo>(context);
    return Center(child: user.avatar);
  }
}
