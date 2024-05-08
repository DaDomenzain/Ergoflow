import 'dart:convert';

import 'package:ergo_flow/providers/ble_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:provider/provider.dart';

class ReceiveData extends StatefulWidget {
  ReceiveData({super.key});
  final Map<Guid, List<int>> readValues = <Guid, List<int>>{};

  @override
  State<ReceiveData> createState() => _ReceiveDataState();
}

class _ReceiveDataState extends State<ReceiveData> {
  ElevatedButton startReceivingData(
      BuildContext context, BluetoothCharacteristic characteristic) {
    final bleState = Provider.of<BleState>(context);
    ElevatedButton button =
        const ElevatedButton(onPressed: null, child: Text('Comenzar medición'));
    if (characteristic.properties.notify) {
      button = ElevatedButton(
        child: const Text('Comenzar medición',
            style: TextStyle(color: Colors.black)),
        onPressed: () async {
          characteristic.lastValueStream.listen((value) {
            setState(() {
              widget.readValues[characteristic.uuid] = value;
            });
          });
          await characteristic.setNotifyValue(true);
          bleState.notifyState = true;
        },
      );
    }

    return button;
  }

  ElevatedButton stopReceivingData(
      BuildContext context, BluetoothCharacteristic characteristic) {
    final bleState = Provider.of<BleState>(context);
    ElevatedButton button =
        const ElevatedButton(onPressed: null, child: Text('Detener medición'));
    if (bleState.notifyState) {
      button = ElevatedButton(
        child: const Text('Detener medición',
            style: TextStyle(color: Colors.black)),
        onPressed: () async {
          await characteristic.setNotifyValue(false);
          bleState.notifyState = false;
        },
      );
    }
    return button;
  }

  Column buildView(BuildContext context) {
    final bleState = Provider.of<BleState>(context);
    final utf8Decoder = utf8.decoder;
    var connectedButtons = const Column();
    int cont = 0;
    for (BluetoothService service in bleState.services) {
      if (cont == 2) {
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          if (characteristic.properties.notify) {
            String decodedBytes = '';
            List<int>? encodedBytes = widget.readValues[characteristic.uuid];
            // ignore: unnecessary_null_comparison
            if (encodedBytes?.where((e) => e != null).toList().isEmpty ??
                true) {
              decodedBytes = '';
            } else {
              decodedBytes = utf8Decoder.convert(encodedBytes!);
            }
            connectedButtons = Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    startReceivingData(context, characteristic),
                    stopReceivingData(context, characteristic)
                  ],
                ),
                Text('Value: $decodedBytes'),
              ],
            );
          }
        }
      }
      cont += 1;
    }

    return connectedButtons;
  }

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }
}

//Create button to start receving data

