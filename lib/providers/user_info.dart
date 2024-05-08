import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {
  late double _height;
  late double _weight;
  late int _age;
  late String _sex;
  String _name = 'Usuario';
  Image _avatar = Image.asset('assets/images/avatar_h_1.jpg');

  double get height {
    return _height;
  }

  double get weight {
    return _weight;
  }

  set weight(double value) {
    _weight = value;
    notifyListeners();
  }

  set height(double value) {
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

  Image get avatar {
    return _avatar;
  }

  set avatar(Image value) {
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
}
