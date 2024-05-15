import 'package:ergo_flow/providers/ble_state.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class Chart extends StatefulWidget {
  String datatest;
  Chart({super.key, required this.datatest});
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<Data> _chartData;
  List<double> _pressChartData = [];
  List<double> _timeEspiracion = [];
  int timeCounter = 0;
  //late ChartSeriesController _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;
  late Timer timer;
  double time = 0;
  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true);
    _chartData = getChartData();
    Timer.periodic(const Duration(milliseconds: 100), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bleState = Provider.of<BleState>(context);
    if (bleState.notifyState) {
      return SfCartesianChart(
        zoomPanBehavior: _zoomPanBehavior,
        primaryXAxis: const NumericAxis(
          maximum: 20,
          minimum: 0,
        ),
        primaryYAxis: const NumericAxis(
          maximum: 4,
          minimum: 0,
        ),
        series: <CartesianSeries>[
          SplineSeries<Data, double>(
            onRendererCreated: (ChartSeriesController controller) {
              //_chartSeriesController = controller;
            },
            dataSource: _chartData,
            xValueMapper: (Data voltage, _) => voltage.time,
            yValueMapper: (Data voltage, _) => voltage.voltage,
            //markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
      );
    } else {
      _chartData = [];
      if (mounted) {
        setState(() {
          time = 0;
        });
      }
      return SfCartesianChart(
        zoomPanBehavior: _zoomPanBehavior,
        primaryXAxis: const NumericAxis(
          maximum: 20,
          minimum: 0,
        ),
        primaryYAxis: const NumericAxis(
          maximum: 4,
          minimum: 0,
        ),
      );
    }
  }

  void updateDataSource(Timer timer) {
    _chartData.add(Data(time = time + 0.1, double.parse(widget.datatest)));
    if (_chartData.last.voltage > 0.2) {
      _pressChartData.add(_chartData.last.voltage);
      if (timeCounter == 0) {
        _timeEspiracion.add(_chartData.last.time);
      }
    }

    //_pressChartData
    //_chartData.removeAt(0);
    //_chartSeriesController.updateDataSource(addedDataIndex: _chartData.length - 1);
  }

  List<Data> getChartData() {
    final List<Data> chartData = [];

    return chartData;
  }
}

class Data {
  Data(this.time, this.voltage);
  final double time;
  final double voltage;
}
