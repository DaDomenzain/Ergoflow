import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleState with ChangeNotifier {
  bool _connectionState = false;
  bool _notifyState = false;
  BluetoothDevice? _connectedDevice;
  List<BluetoothService> _services = [];

  bool get connectionState {
    return _connectionState;
  }

  bool get notifyState {
    return _notifyState;
  }

  BluetoothDevice? get connectedDevice {
    return _connectedDevice;
  }

  List<BluetoothService> get services {
    return _services;
  }

  set connectionState(bool state) {
    _connectionState = state;
    notifyListeners();
  }

  set notifyState(bool state) {
    _notifyState = state;
    notifyListeners();
  }

  set connectedDevice(BluetoothDevice? device) {
    _connectedDevice = device;
    notifyListeners();
  }

  set services(List<BluetoothService> serviceList) {
    _services = serviceList;
    notifyListeners();
  }
}
