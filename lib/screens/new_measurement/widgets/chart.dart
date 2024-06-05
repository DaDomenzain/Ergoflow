import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/hr_vo2max_functions.dart';
import 'package:ergo_flow/logic/measurement.dart';
import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/providers/ble_state.dart';
import 'package:ergo_flow/providers/measurement_state.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:ergo_flow/screens/new_measurement/widgets/measurement_phase.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
  //Lists that save all required data
  late List<Data> _chartData;
  late List<FinalData> _vo2Data;
  late List<FinalData> _vco2Data;
  late List<FinalData> _hrData;
  late List<FinalData> _veData;
  late List<FinalData> _vtData;

  //Aux lists that save partial data (data that is further modified)
  List<double> _pressChartData = [];
  final List<double> _timeEspiracion = [];
  List<double> co2values = [];
  List<double> o2values = [];
  List<double> tempvalues = [];
  List<double> heartrateValues = [];

  //VO2max calculation variables
  late double co2prom;
  late double o2prom;
  late double tempprom;
  late double elapsedTime;
  late double volFlow;
  double vo2max = 0;
  double vco2max = 0;
  double ve = 0;
  double vt = 0;

  //Heart Rate value
  int heartrate = 0;

  //Bool variables to determine instance of breathing
  bool isFlowCalculated = false;
  bool timeCounter = false;
  bool firstEsp = true;

  //Timer
  late Timer timer;
  double time = 0;
  List<double> timestamps = [];

  //Controllers
  late ZoomPanBehavior _zoomPanBehavior;
  final profileController = Get.put(ProfileController());

  //Times
  String restTime = '--:--';
  String excerciseTime = '--:--';
  String recoveryTime = '--:--';

  //Get the average value of a list of doubles
  double getAverageFromList(List<double> list) {
    double sum = 0;
    for (var i = 0; i < list.length; i++) {
      sum = sum + list[i];
    }
    return sum / list.length;
  }

  void calculateTimes() {
    final measurementState = Provider.of<MeasurementState>(context);
    final bleState = Provider.of<BleState>(context);
    if (measurementState.excercise) {
      timestamps.add(time);
      int minutes = (time ~/ 60);
      int seconds = (time % 60).floor();
      if (seconds < 10) {
        restTime = '$minutes:0$seconds';
      } else {
        restTime = '$minutes:$seconds';
      }
      measurementState.excercise = false;
    } else if (measurementState.recovery) {
      timestamps.add(time);
      int minutes = (time ~/ 60);
      int seconds = (time % 60).floor();
      if (seconds < 10) {
        excerciseTime = '$minutes:0$seconds';
      } else {
        excerciseTime = '$minutes:$seconds';
      }
      measurementState.recovery = false;
    } else if (measurementState.rest && !bleState.notifyState) {
      print('AAAA');
      timestamps.add(time);
      int minutes = (time ~/ 60);
      int seconds = (time % 60).floor();
      if (seconds < 10) {
        recoveryTime = '$minutes:0$seconds';
      } else {
        recoveryTime = '$minutes:$seconds';
      }
      measurementState.rest = false;
    }
  }

  Row displayTimes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(restTime, style: const TextStyle(fontSize: 20)),
        Text(excerciseTime, style: const TextStyle(fontSize: 20)),
        Text(recoveryTime, style: const TextStyle(fontSize: 20))
      ],
    );
  }

  @override
  void initState() {
    //Enable zooming and panning for graph
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true);

    //Initialize lists for final data
    _chartData = getChartData();
    _vo2Data = getFinalChartData();
    _vco2Data = getFinalChartData();
    _hrData = getFinalChartData();
    _veData = getFinalChartData();
    _vtData = getFinalChartData();

    //Start timer (this timer calls updateDataSource every 100 ms)
    Timer.periodic(const Duration(milliseconds: 100), updateDataSource);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bleState = Provider.of<BleState>(context);
    final userInfo = Provider.of<MyUserInfo>(context);
    //final measurementState = Provider.of<MeasurementState>(context);
    if (bleState.notifyState) {
      calculateTimes();
      return Column(
        children: [
          MeasurementTimes(time: time),
          displayTimes(),
          SfCartesianChart(
            title: const ChartTitle(text: 'VO2'),
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: const NumericAxis(
              title: AxisTitle(text: 'Tiempo (s)'),
              maximum: 300,
              minimum: 0,
            ),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'VO2max (ml/kg/min)'),
              maximum: 60,
              minimum: 0,
            ),
            series: <CartesianSeries>[
              SplineSeries<FinalData, double>(
                onRendererCreated: (ChartSeriesController controller) {},
                dataSource: _vo2Data,
                xValueMapper: (FinalData time, _) => time.time,
                yValueMapper: (FinalData value, _) => value.value,
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset('assets/images/heart_beat.gif'),
              Text(
                '$heartrate',
                style: TextStyle(
                    color: ColorPalette.blanco,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      );
    } else {
      calculateTimes();
      //If not receiving data, save data,
      //delete all previously saved data and set timer to 0
      if (_chartData.isNotEmpty) {
        Map<String, List> vo2 = {
          'value': _vo2Data.map((data) => data.value).toList(),
          'time': _vo2Data.map((data) => data.time).toList(),
        };

        Map<String, List> vco2 = {
          'value': _vco2Data.map((data) => data.value).toList(),
          'time': _vco2Data.map((data) => data.time).toList(),
        };

        Map<String, List> ve = {
          'value': _veData.map((data) => data.value).toList(),
          'time': _veData.map((data) => data.time).toList()
        };

        Map<String, List> vt = {
          'value': _vtData.map((data) => data.value).toList(),
          'time': _vtData.map((data) => data.time).toList()
        };

        Map<String, List> hr = {
          'value': _hrData.map((data) => data.value).toList(),
          'time': _hrData.map((data) => data.time).toList()
        };

        Measurement measurement = Measurement(
            vo2: vo2,
            vco2: vco2,
            ve: ve,
            vt: vt,
            hr: hr,
            date: Timestamp.now(),
            timestamps: timestamps);
        profileController.createMeasurement(userInfo.id, measurement);
      }

      timestamps = [];
      _vo2Data = [];
      _vco2Data = [];
      _veData = [];
      _vtData = [];
      _chartData = [];
      _hrData = [];
      if (mounted) {
        setState(() {
          time = 0;
        });
      }
      //Return an empty graph
      return Column(
        children: [
          MeasurementTimes(time: time),
          displayTimes(),
          SfCartesianChart(
            title: const ChartTitle(text: 'VO2'),
            zoomPanBehavior: _zoomPanBehavior,
            primaryXAxis: const NumericAxis(
              title: AxisTitle(text: 'Tiempo (s)'),
              maximum: 300,
              minimum: 0,
            ),
            primaryYAxis: const NumericAxis(
              title: AxisTitle(text: 'VO2max (ml/kg/min)'),
              maximum: 60,
              minimum: 0,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.asset('assets/images/heart_beat.gif'),
              Text(
                '$heartrate',
                style: TextStyle(
                    color: ColorPalette.blanco,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      );
    }
  }

  void updateDataSource(Timer timer) {
    if (mounted) {
      //Providers
      final userInfo = Provider.of<MyUserInfo>(context, listen: false);
      final bleState = Provider.of<BleState>(context, listen: false);

      //Only do this when receiving data through BLE
      if (bleState.notifyState) {
        //Round time to 2 decimal places
        time = double.parse((time + 0.1).toStringAsFixed(2));
        //Save received voltages in chartData
        _chartData.add(Data(
            time,
            double.parse(widget.pressureV),
            double.parse(widget.co2V),
            double.parse(widget.tempV),
            double.parse(widget.o2V),
            double.parse(widget.heartrateV)));

        //Heart rate calculation
        heartrateValues.add(double.parse(widget.heartrateV));
        if (time % 5 == 0.0) {
          //Calculate HR every 5 seconds
          int myHeartRate = heartRate(heartrateValues);
          _hrData.add(FinalData(time, myHeartRate.toDouble()));
          heartrateValues = [];
          heartrate = _hrData.last.value.toInt();
        }

        //If pressure voltage surpasses 0.05, an espiration is happening
        if (_chartData.last.pressV > 0.055) {
          //Check if first breathing cyle already happenned
          if (!timeCounter && firstEsp) {
            timeCounter = true;
            firstEsp = false;
            _timeEspiracion.add(_chartData.last.time);
            _pressChartData.add(_chartData.last.pressV);
            o2values.add(_chartData.last.o2V);
            co2values.add(_chartData.last.co2V);
            tempvalues.add(_chartData.last.tempV);
            //Only if first cycle already happened and next cycle is starting,
            //calculate vo2max
          } else if (!timeCounter) {
            timeCounter = true;
            _timeEspiracion.add(_chartData.last.time);
            //Calculate elapsed time
            elapsedTime = _timeEspiracion[1] - _timeEspiracion[0];
            //Calculate vo2, vco2, ve & vt
            var (vo2max, vco2max, ve, vt) = vo2Max(co2prom, tempprom, o2prom,
                volFlow, elapsedTime, userInfo.weight);
            //Add results to list
            _vo2Data.add(FinalData(time, vo2max));
            _vco2Data.add(FinalData(time, vco2max));
            _veData.add(FinalData(time, ve));
            _vtData.add(FinalData(time, vt));
            //Empty aux lists
            _pressChartData = [];
            o2values = [];
            co2values = [];
            tempvalues = [];
            //Remove first time value (from to last breath)
            _timeEspiracion.removeAt(0);
            //Start adding new values (from latest breath)
            _pressChartData.add(_chartData.last.pressV);
            o2values.add(_chartData.last.o2V);
            co2values.add(_chartData.last.co2V);
            tempvalues.add(_chartData.last.tempV);
            isFlowCalculated = false;
            //Espiration is still happening, therefore only save data
          } else {
            _pressChartData.add(_chartData.last.pressV);
            o2values.add(_chartData.last.o2V);
            co2values.add(_chartData.last.co2V);
            tempvalues.add(_chartData.last.tempV);
          }
          // If is under 0.05, either a first espiration is yet to happen or the
          //person is inspiring. Only in secind case calculate air flow
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
  }

  //List initializers
  List<FinalData> getFinalChartData() {
    final List<FinalData> finalData = [];
    return finalData;
  }

  List<Data> getChartData() {
    final List<Data> chartData = [];
    return chartData;
  }
}

//Data type contains time and every voltage value coming from sensors
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

//FinalData type contains only time and the value corresponding to said time
class FinalData {
  FinalData(this.time, this.value);
  final double time;
  final double value;
}
