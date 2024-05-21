import 'package:ergo_flow/logic/hr_vo2max_functions.dart';
import 'package:ergo_flow/providers/ble_state.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'dart:async';

// ignore: must_be_immutable
class Chart extends StatefulWidget {
  String pressureV;
  String o2V;
  String co2V;
  String heartrateV;
  String tempV;

  Chart(
      {super.key,
      required this.pressureV,
      required this.co2V,
      required this.tempV,
      required this.o2V,
      required this.heartrateV});
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<Data> _chartData;
  late List<FinalData> _finalData;
  List<double> _pressChartData = [];
  List<double> _timeEspiracion = [];
  List<double> co2values = [];
  List<double> o2values = [];
  List<double> tempvalues = [];
  List<double> heartrateValues = [];
  late double co2prom;
  late double o2prom;
  late double tempprom;
  late double elapsedTime;
  double vo2max = 0;

  bool isFlowCalculated = false;
  bool timeCounter = false;
  bool firstEsp = true;
  late double volFlow;
  //late ChartSeriesController _chartSeriesController;
  late ZoomPanBehavior _zoomPanBehavior;
  late Timer timer;
  double time = 0;

  double getAverageFromList(List<double> list) {
    double sum = 0;
    for (var i = 0; i < list.length; i++) {
      sum = sum + list[i];
    }
    return sum / list.length;
  }

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true);
    _chartData = getChartData();
    _finalData = getFinalChartData();

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
          maximum: 120,
          minimum: 0,
        ),
        primaryYAxis: const NumericAxis(
          maximum: 40,
          minimum: 0,
        ),
        series: <CartesianSeries>[
          SplineSeries<FinalData, double>(
            onRendererCreated: (ChartSeriesController controller) {
              //_chartSeriesController = controller;
            },
            dataSource: _finalData,
            xValueMapper: (FinalData time, _) => time.time,
            yValueMapper: (FinalData vo2max, _) => vo2max.vo2max,
            //markerSettings: const MarkerSettings(isVisible: true),
          ),
        ],
      );
    } else {
      _finalData = [];
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
          maximum: 60,
          minimum: 0,
        ),
      );
    }
  }

  void updateDataSource(Timer timer) {
    if (mounted) {
      final userInfo = Provider.of<MyUserInfo>(context, listen: false);
      final bleState = Provider.of<BleState>(context, listen: false);
      if (bleState.notifyState) {
        _finalData.add(FinalData(time = time + 0.1, vo2max));
        //print(vo2max);
        _chartData.add(Data(
            time = time + 0.1,
            double.parse(widget.pressureV),
            double.parse(widget.co2V),
            double.parse(widget.tempV),
            double.parse(widget.o2V),
            double.parse(widget.heartrateV)));
        if (_chartData.last.pressV > 0.2) {
          if (!timeCounter && firstEsp) {
            timeCounter = true;
            firstEsp = false;
            _timeEspiracion.add(_chartData.last.time);
            _pressChartData.add(_chartData.last.pressV);
            o2values.add(_chartData.last.o2V);
            co2values.add(_chartData.last.co2V);
            tempvalues.add(_chartData.last.tempV);
          } else if (!timeCounter) {
            timeCounter = true;
            _timeEspiracion.add(_chartData.last.time);
            elapsedTime =
                _timeEspiracion[1] - _timeEspiracion[0]; //Calcular elapsed time
            vo2max = vo2Max(co2prom, tempprom, o2prom, volFlow, elapsedTime,
                userInfo.weight);
            _pressChartData = [];
            o2values = [];
            co2values = [];
            tempvalues = [];
            _timeEspiracion.removeAt(0);
            _pressChartData.add(_chartData.last.pressV);
            o2values.add(_chartData.last.o2V);
            co2values.add(_chartData.last.co2V);
            tempvalues.add(_chartData.last.tempV);
            isFlowCalculated = false;
          } else {
            _pressChartData.add(_chartData.last.pressV);
            o2values.add(_chartData.last.o2V);
            co2values.add(_chartData.last.co2V);
            tempvalues.add(_chartData.last.tempV);
          }
        } else if (!isFlowCalculated && !firstEsp) {
          o2prom = getAverageFromList(o2values);
          co2prom = getAverageFromList(co2values);
          tempprom = getAverageFromList(tempvalues);
          volFlow = flujoEspiraciones(_pressChartData);
          isFlowCalculated = true;
          timeCounter = false;
        }
      }
    }

    //_pressChartData
    //_chartData.removeAt(0);
    //_chartSeriesController.updateDataSource(addedDataIndex: _chartData.length - 1);
  }

  List<FinalData> getFinalChartData() {
    final List<FinalData> finalData = [];

    return finalData;
  }

  List<Data> getChartData() {
    final List<Data> chartData = [];

    return chartData;
  }
}

class Data {
  Data(
      this.time, this.pressV, this.co2V, this.tempV, this.o2V, this.heartrateV);
  final double time;
  final double pressV;
  final double co2V;
  final double tempV;
  final double o2V;
  final double heartrateV;
}

class FinalData {
  FinalData(this.time, this.vo2max);
  final double time;
  final double vo2max;
}
