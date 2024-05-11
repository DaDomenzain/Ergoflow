import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool ispassword;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.ispassword});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  final FocusNode myFocusNode = FocusNode();

  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    if (widget.ispassword) {
      return TextField(
        controller: widget.controller,
        focusNode: myFocusNode,
        decoration: InputDecoration(
            filled: true,
            fillColor: ColorPalette.gris4,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorPalette.gris4)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: ColorPalette.azul)),
            hintText: myFocusNode.hasFocus ? widget.hintText : '',
            hintStyle: TextStyle(color: ColorPalette.gris2),
            labelText: widget.hintText,
            labelStyle: TextStyle(color: ColorPalette.azul),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: ColorPalette.gris2,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )),
        obscureText: !_passwordVisible,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      );
    } else {
      return TextField(
        controller: widget.controller,
        focusNode: myFocusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor: ColorPalette.gris4,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorPalette.gris4)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: ColorPalette.azul)),
          hintText: myFocusNode.hasFocus ? widget.hintText : '',
          hintStyle: TextStyle(color: ColorPalette.gris2),
          labelText: widget.hintText,
          labelStyle: TextStyle(color: ColorPalette.azul),
        ),
        obscureText: widget.ispassword,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      );
    }
  }
}
