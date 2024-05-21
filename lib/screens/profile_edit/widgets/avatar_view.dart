import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

class AvatarView extends StatelessWidget {
  const AvatarView(
      {super.key, this.path, required this.onTap, required this.selected});

  final String? path;
  final VoidCallback? onTap;
  final bool? selected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    selected ?? false ? ColorPalette.azul : ColorPalette.blanco,
                width: 2)),
        child: Image.asset(
          path!,
          fit: BoxFit.cover, // Fixes border issues
        ),
      ),
    );
  }
}
