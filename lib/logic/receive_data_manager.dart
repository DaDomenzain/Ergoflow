import 'dart:convert';

import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/providers/ble_state.dart';
import 'package:ergo_flow/providers/measurement_state.dart';
import 'package:ergo_flow/screens/new_measurement/widgets/chart.dart';
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
  ElevatedButton startReceivingData(BuildContext context,
      {BluetoothCharacteristic? characteristic}) {
    final bleState = Provider.of<BleState>(context);
    final measurementState = Provider.of<MeasurementState>(context);
    ElevatedButton button =
        const ElevatedButton(onPressed: null, child: Text('Comenzar medición'));
    if (characteristic != null) {
      if (characteristic.properties.notify) {
        if (!bleState.notifyState) {
          button = ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: ColorPalette.azul),
            child: Text('Comenzar medición',
                style: TextStyle(color: ColorPalette.blanco)),
            onPressed: () async {
              measurementState.rest = true;
              characteristic.lastValueStream.listen((value) {
                if (mounted) {
                  setState(() {
                    widget.readValues[characteristic.uuid] = value;
                  });
                }
              });
              await characteristic.setNotifyValue(true);
              bleState.notifyState = true;
            },
          );
        }
      }
    }

    return button;
  }

  ElevatedButton stopReceivingData(BuildContext context,
      {BluetoothCharacteristic? characteristic}) {
    final bleState = Provider.of<BleState>(context);
    ElevatedButton button =
        const ElevatedButton(onPressed: null, child: Text('Detener medición'));
    if (characteristic != null) {
      if (bleState.notifyState) {
        button = ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ColorPalette.azul),
          child: Text('Detener medición',
              style: TextStyle(color: ColorPalette.blanco)),
          onPressed: () async {
            await characteristic.setNotifyValue(false);
            bleState.notifyState = false;
          },
        );
      }
    }
    return button;
  }

  Column buildView(BuildContext context) {
    final bleState = Provider.of<BleState>(context);
    final utf8Decoder = utf8.decoder;
    var connectedButtons = const Column();
    if (bleState.connectionState) {
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
                connectedButtons = Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              startReceivingData(context,
                                  characteristic: characteristic),
                              stopReceivingData(context,
                                  characteristic: characteristic)
                            ],
                          ),
                        ),
                        Text('Value: $decodedBytes'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 15),
                      child: Chart(
                        pressureV: '0.0',
                        o2V: '0.0',
                        co2V: '0.0',
                        heartrateV: '0.0',
                        tempV: '0.0',
                      ),
                    )
                  ],
                );
              } else {
                decodedBytes = utf8Decoder.convert(encodedBytes!);
                List<String> receivedData = decodedBytes.split(',');
                String pressureV = receivedData[0];
                String co2V = receivedData[1];
                String temp = receivedData[2];
                String o2V = receivedData[3];
                String heartRateV = receivedData[4];

                //String newdecoded = decodedBytes;
                connectedButtons = Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              startReceivingData(context,
                                  characteristic: characteristic),
                              stopReceivingData(context,
                                  characteristic: characteristic)
                            ],
                          ),
                        ),
                        Text('Value: $heartRateV'),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 15),
                      child: Chart(
                        pressureV: pressureV,
                        co2V: co2V,
                        tempV: temp,
                        o2V: o2V,
                        heartrateV: heartRateV,
                      ),
                    )
                  ],
                );
              }
            }
          }
        }
        cont += 1;
      }
    } else {
      connectedButtons = Column(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  startReceivingData(context),
                  stopReceivingData(context)
                ],
              ),
              const Text(
                'No hay dispositivos conectados',
                style: TextStyle(color: Colors.redAccent),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 15),
            child: Chart(
              pressureV: '0.0',
              o2V: '0.0',
              co2V: '0.0',
              heartrateV: '0.0',
              tempV: '0.0',
            ),
          )
        ],
      );
    }

    return connectedButtons;
  }

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }
}

//Create button to start receving data

