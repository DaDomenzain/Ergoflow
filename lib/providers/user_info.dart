import 'package:flutter/material.dart';

class MyUserInfo with ChangeNotifier {
  late int _height;
  late int _weight;
  late int _age;
  late String _sex;
  String _name = 'Usuario';
  String _avatar = 'assets/images/avatar_h_1.jpg';
  late String? _email;

  int get height {
    return _height;
  }

  int get weight {
    return _weight;
  }

  set weight(int value) {
    _weight = value;
    notifyListeners();
  }

  set height(int value) {
    _height = value;
    notifyListeners();
  }

  String get name {
    return _name;
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get avatar {
    return _avatar;
  }

  set avatar(String value) {
    _avatar = value;
    notifyListeners();
  }

  int get age {
    return _age;
  }

  set age(int value) {
    _age = value;
    notifyListeners();
  }

  String get sex {
    return _sex;
  }

  set sex(String value) {
    _sex = value;
    notifyListeners();
  }

  String? get email {
    return _email;
  }

  set email(String? value) {
    _email = value;
  }
}
