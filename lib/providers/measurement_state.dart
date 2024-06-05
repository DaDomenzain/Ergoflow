import 'package:flutter/material.dart';

class MeasurementState with ChangeNotifier {
  bool _rest = false;
  bool _excercise = false;
  bool _recovery = false;
  String _restTime = '--:--';
  String _excerciseTime = '--:--';
  String _recoveryTime = '--:--';

  bool get rest {
    return _rest;
  }

  bool get excercise {
    return _excercise;
  }

  set rest(bool state) {
    _rest = state;
    ;
  }

  set excercise(bool state) {
    _excercise = state;
    ;
  }

  bool get recovery {
    return _recovery;
  }

  set recovery(bool state) {
    _recovery = state;
    ;
  }

  String get restTime {
    return _restTime;
  }

  set restTime(String state) {
    _restTime = state;
    notifyListeners();
  }

  String get excerciseTime {
    return _excerciseTime;
  }

  set excerciseTime(String state) {
    _excerciseTime = state;
    notifyListeners();
  }

  String get recoveryTime {
    return _recoveryTime;
  }

  set recoveryTime(String state) {
    _recoveryTime = state;
    notifyListeners();
  }
}
