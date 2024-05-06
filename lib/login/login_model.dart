import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  final unfocusNode = FocusNode();
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(String?)? emailAddressValidator;
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  String? Function(String?)? passwordValidator;

  bool _passwordVisible = false;
  bool get passwordVisible => _passwordVisible;

  LoginModel() {
    emailAddressFocusNode = FocusNode();
    emailAddressTextController = TextEditingController();
    passwordFocusNode = FocusNode();
    passwordTextController = TextEditingController();
  }

  void togglePasswordVisibility() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    unfocusNode.dispose();
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();
    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
