import 'package:ergo_flow/config/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:ergo_flow/providers/ble_state.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleManager extends StatefulWidget {
  BleManager({super.key});

  final List<BluetoothDevice> devicesList = <BluetoothDevice>[];
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};

  @override
  BleManagerState createState() => BleManagerState();
}

class BleManagerState extends State<BleManager> {
  //BluetoothDevice? _connectedDevice;
  //List<BluetoothService> _services = []

  //Add Bluetooth Device to list of possible devices
  _addDeviceTolist(final BluetoothDevice device) {
    if (!widget.devicesList.contains(device)) {
      setState(() {
        widget.devicesList.add(device);
      });
    }
  }

  //Intialize Bluetooth search
  _initBluetooth() async {
    var subscription = FlutterBluePlus.onScanResults.listen(
      (results) {
        if (results.isNotEmpty) {
          for (ScanResult result in results) {
            _addDeviceTolist(result.device);
          }
        }
      },
      onError: (e) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      ),
    );

    FlutterBluePlus.cancelWhenScanComplete(subscription);

    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    await FlutterBluePlus.startScan();

    await FlutterBluePlus.isScanning.where((val) => val == false).first;
    FlutterBluePlus.connectedDevices.map((device) {
      _addDeviceTolist(device);
    });
  }

  @override
  void initState() {
    () async {
      var status = await Permission.location.status;
      if (status.isDenied) {
        final status = await Permission.location.request();
        if (status.isGranted || status.isLimited) {
          _initBluetooth();
        }
      } else if (status.isGranted || status.isLimited) {
        _initBluetooth();
      }

      if (await Permission.location.status.isPermanentlyDenied) {
        openAppSettings();
      }
    }();
    super.initState();
  }

  //Create button to connect to device
  ElevatedButton connectToDevice(BuildContext context) {
    final bleState = Provider.of<BleState>(context);
    return ElevatedButton(
        onPressed: () async {
          for (BluetoothDevice device in widget.devicesList) {
            if (device.advName == 'LAMANIOSA') {
              FlutterBluePlus.stopScan();
              try {
                await device.connect();
              } on PlatformException catch (e) {
                if (e.code != 'already_connected') {
                  rethrow;
                }
              } finally {
                //_services = await device.discoverServices();
                bleState.connectionState = true;
                bleState.connectedDevice = device;
                bleState.services = await device.discoverServices();
              }
              // setState(() {
              //   _connectedDevice = device;
              // });
            }
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(ColorPalette.azul),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ))),
        child: Text(
          'Conectar dispositivo',
          style: TextStyle(color: ColorPalette.blanco),
        ));
  }

  //Create button to disconnect device
  ElevatedButton disconnectDevice(BuildContext context) {
    final bleState = Provider.of<BleState>(context);
    return ElevatedButton(
      child: const Text('Desconectar dispositivo'),
      onPressed: () {
        if (bleState.connectedDevice != null) {
          bleState.connectedDevice!.disconnect();
          bleState.connectedDevice = null;
          bleState.connectionState = false;
        }
      },
    );
  }

  //Select wether to return connect or disconnect button
  ElevatedButton buildView(BuildContext context) {
    final bleState = Provider.of<BleState>(context);
    if (bleState.connectionState) {
      return disconnectDevice(context);
    }
    return connectToDevice(context);
  }

  @override
  Widget build(BuildContext context) {
    return buildView(context); //Returns an elevated button
  }
}
