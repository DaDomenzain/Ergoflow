import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/measurement.dart';
import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:ergo_flow/screens/global_widgets/go_back.dart';
import 'package:ergo_flow/screens/global_widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// ignore: must_be_immutable
class HistoryDetails extends StatelessWidget {
  int selectedMeasurement;
  HistoryDetails({super.key, required this.selectedMeasurement});

  //VO2 (standarized by weight) & HR vs time
  SfCartesianChart createVO2Chart(Measurement measurement) {
    List<ChartData> data1 = [];
    List times1 = measurement.vo2['time'];
    List values1 = measurement.vo2['value'];
    if (times1.isNotEmpty) {
      for (var i = 0; i < times1.length; i++) {
        data1.add(ChartData(times1[i], values1[i]));
      }
    }

    List<ChartData> data2 = [];
    List times2 = measurement.hr['time'];
    List values2 = measurement.hr['value'];
    if (times2.isNotEmpty) {
      for (var i = 0; i < times2.length; i++) {
        data2.add(ChartData(times2[i], values2[i]));
      }
    }
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'VO2'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'Tiempo (s)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'VO2max (ml/kg/min)')),
      axes: const [
        NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
            name: 'yAxis',
            title: AxisTitle(text: 'Frecuencia cardíaca (lpm)'),
            opposedPosition: true)
      ],
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 70,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 70,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        SplineSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
        SplineSeries<ChartData, num>(
          color: Colors.red,
          dataSource: data2,
          xValueMapper: (ChartData data2, _) => data2.x,
          yValueMapper: (ChartData data2, _) => data2.y,
          yAxisName: 'yAxis',
        )
      ],
    );
  }

  //VE vs time
  SfCartesianChart panel1(Measurement measurement) {
    List<ChartData> data1 = [];
    List times1 = measurement.ve['time'];
    List values1 = measurement.ve['value'];
    if (times1.isNotEmpty) {
      for (var i = 0; i < times1.length; i++) {
        data1.add(ChartData(times1[i], values1[i]));
      }
    }

    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'VE'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'Tiempo (s)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'VE (L/min)')),
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 70,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 70,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
      ],
    );
  }

  //HR & O2 pulse vs time
  SfCartesianChart panel2(Measurement measurement, BuildContext context) {
    final userInfo = Provider.of<MyUserInfo>(context);
    List<ChartData> data1 = [];
    List times1 = measurement.hr['time'];
    List values1 = measurement.hr['value'];
    if (times1.isNotEmpty) {
      for (var i = 0; i < times1.length; i++) {
        data1.add(ChartData(times1[i], values1[i]));
      }
    }

    List<ChartData> data2 = [];
    List times2 = measurement.vo2['time'];
    List values2 = measurement.vo2['value'];
    double hrForThisValue = 0;
    if (times2.isNotEmpty) {
      for (var i = 0; i < times2.length; i++) {
        for (var j = 0; j < times1.length; j++) {
          if (times2[i] < times1[j]) {
            if (j == 0) {
              hrForThisValue = 60;
            } else {
              hrForThisValue = values1[j - 1];
            }
            if (hrForThisValue == 0) {
              hrForThisValue = 60;
            }
            break;
          }
        }

        data2.add(ChartData(
            times2[i], values2[i] / hrForThisValue * userInfo.weight));
      }
    }
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'FC y O2 por pulso'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'Tiempo (s)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'Frecuencia cardíaca (lpm)')),
      axes: const [
        NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
            name: 'yAxis',
            title: AxisTitle(text: 'VO2/FC (ml/min/lpm)'),
            opposedPosition: true)
      ],
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 180,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 180,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
        ScatterSeries<ChartData, num>(
          color: Colors.red,
          dataSource: data2,
          xValueMapper: (ChartData data2, _) => data2.x,
          yValueMapper: (ChartData data2, _) => data2.y,
          yAxisName: 'yAxis',
        )
      ],
    );
  }

  //VO2 & VCO2 vs time
  SfCartesianChart panel3(Measurement measurement, BuildContext context) {
    final userInfo = Provider.of<MyUserInfo>(context);
    List<ChartData> data1 = [];
    List times1 = measurement.vo2['time'];
    List values1 = measurement.vo2['value'];
    if (times1.isNotEmpty) {
      for (var i = 0; i < times1.length; i++) {
        data1.add(ChartData(times1[i], values1[i] * userInfo.weight));
      }
    }

    List<ChartData> data2 = [];
    List times2 = measurement.vco2['time'];
    List values2 = measurement.vco2['value'];
    if (times2.isNotEmpty) {
      for (var i = 0; i < times2.length; i++) {
        data2.add(ChartData(times2[i], values2[i] * userInfo.weight));
      }
    }
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'VO2 y VCO2'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'Tiempo (s)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'VO2 (ml/min)')),
      axes: const [
        NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
            name: 'yAxis',
            title: AxisTitle(text: 'VCO2(ml/min)'),
            opposedPosition: true)
      ],
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 5500,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 5500,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
        ScatterSeries<ChartData, num>(
          color: Colors.red,
          dataSource: data2,
          xValueMapper: (ChartData data2, _) => data2.x,
          yValueMapper: (ChartData data2, _) => data2.y,
          yAxisName: 'yAxis',
        )
      ],
    );
  }

  //VE vs VCO2
  SfCartesianChart panel4(Measurement measurement, BuildContext context) {
    final userInfo = Provider.of<MyUserInfo>(context);
    List<ChartData> data1 = [];
    List values1 = measurement.ve['value'];
    List values2 = measurement.vco2['value'];
    if (values2.isNotEmpty) {
      for (var i = 0; i < values2.length; i++) {
        data1.add(ChartData(values2[i] * userInfo.weight, values1[i]));
      }
    }

    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'Relación entre VE y VCO2'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'VCO2 (ml/min)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'VE (L/min)')),
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 5500,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 5500,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
      ],
    );
  }

  //HR & VCO2 vs VO2
  SfCartesianChart panel5(Measurement measurement, BuildContext context) {
    final userInfo = Provider.of<MyUserInfo>(context);
    List<ChartData> data1 = [];
    List values1 = measurement.hr['value'];
    List times1 = measurement.hr['time'];
    List values2 = measurement.vo2['value'];
    List times2 = measurement.vo2['time'];
    double hrForThisValue = 0;

    if (times2.isNotEmpty) {
      for (var i = 0; i < times2.length; i++) {
        for (var j = 0; j < times1.length; j++) {
          if (times2[i] < times1[j]) {
            if (j == 0) {
              hrForThisValue = 60;
            } else {
              hrForThisValue = values1[j - 1];
            }
            if (hrForThisValue == 0) {
              hrForThisValue = 60;
            }
            break;
          }
        }
        data1.add(ChartData(values2[i] * userInfo.weight, hrForThisValue));
      }
    }

    List<ChartData> data2 = [];
    List values3 = measurement.vco2['value'];
    if (values2.isNotEmpty) {
      for (var i = 0; i < values2.length; i++) {
        data2.add(ChartData(
            values3[i] * userInfo.weight, values2[i] * userInfo.weight));
      }
    }

    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'Relación de FC y VCO2 con VO2'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'VO2 (ml/min)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'Frecuencia cardíaca (lpm)')),
      axes: const [
        NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
            name: 'yAxis',
            title: AxisTitle(text: 'VCO2 (ml/min)'),
            opposedPosition: true)
      ],
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 180,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 180,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
        ScatterSeries<ChartData, num>(
          color: Colors.red,
          dataSource: data2,
          xValueMapper: (ChartData data2, _) => data2.x,
          yValueMapper: (ChartData data2, _) => data2.y,
          yAxisName: 'yAxis',
        )
      ],
    );
  }

  //EqO2 & EqCO2 vs time
  SfCartesianChart panel6(Measurement measurement, BuildContext context) {
    final userInfo = Provider.of<MyUserInfo>(context);
    List<ChartData> data1 = [];
    List times1 = measurement.vo2['time'];
    List values1 = measurement.vo2['value'];
    List div = measurement.ve['value'];
    if (times1.isNotEmpty) {
      for (var i = 0; i < times1.length; i++) {
        data1.add(ChartData(
            times1[i], div[i] / (values1[i] * userInfo.weight / 1000)));
      }
    }

    List<ChartData> data2 = [];
    List times2 = measurement.vco2['time'];
    List values2 = measurement.vco2['value'];
    if (times2.isNotEmpty) {
      for (var i = 0; i < times2.length; i++) {
        data2.add(ChartData(
            times2[i], div[i] / (values2[i] * userInfo.weight / 1000)));
      }
    }
    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'EqO2 y EqCO2'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'Tiempo (s)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'VE/VO2')),
      axes: const [
        NumericAxis(
            majorGridLines: MajorGridLines(width: 0),
            name: 'yAxis',
            title: AxisTitle(text: 'VE/VCO2'),
            opposedPosition: true)
      ],
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 50,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 50,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
        ScatterSeries<ChartData, num>(
          color: Colors.red,
          dataSource: data2,
          xValueMapper: (ChartData data2, _) => data2.x,
          yValueMapper: (ChartData data2, _) => data2.y,
          yAxisName: 'yAxis',
        )
      ],
    );
  }

  //VT vs VE
  SfCartesianChart panel7(Measurement measurement) {
    List<ChartData> data1 = [];
    List values1 = measurement.ve['value'];
    List values2 = measurement.vt['value'];
    if (values1.isNotEmpty) {
      for (var i = 0; i < values1.length; i++) {
        data1.add(ChartData(values1[i], values2[i]));
      }
    }

    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'Relación entre VT y VE'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'VE (L/min)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'VT (L)')),
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 3,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 3,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
      ],
    );
  }

  //RER vs time
  SfCartesianChart panel8(Measurement measurement) {
    List<ChartData> data1 = [];
    List times1 = measurement.vo2['time'];
    List values1 = measurement.vo2['value'];
    List values2 = measurement.vco2['value'];
    if (times1.isNotEmpty) {
      for (var i = 0; i < times1.length; i++) {
        data1.add(ChartData(times1[i], values2[i] / values1[i]));
      }
    }

    return SfCartesianChart(
      zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true, zoomMode: ZoomMode.xy, enablePanning: true),
      title: const ChartTitle(text: 'RER'),
      primaryXAxis: NumericAxis(
        majorGridLines: const MajorGridLines(width: 0),
        plotBands: [
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[0],
              end: measurement.timestamps[0] + 1),
          PlotBand(
              color: Colors.green,
              start: measurement.timestamps[1],
              end: measurement.timestamps[1] + 1)
        ],
        title: const AxisTitle(text: 'Tiempo (s)'),
      ),
      primaryYAxis: const NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          title: AxisTitle(text: 'RER')),
      annotations: <CartesianChartAnnotation>[
        CartesianChartAnnotation(
            widget: const Text(
              ' Inicio ejercicio',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[0],
            y: 1.5,
            horizontalAlignment: ChartAlignment.near),
        CartesianChartAnnotation(
            widget: const Text(
              'Fin ejercicio ',
              style: TextStyle(fontSize: 8),
            ),
            coordinateUnit: CoordinateUnit.point,
            x: measurement.timestamps[1],
            y: 1.5,
            horizontalAlignment: ChartAlignment.far)
      ],
      series: <CartesianSeries<ChartData, dynamic>>[
        ScatterSeries<ChartData, num>(
            color: ColorPalette.azul,
            dataSource: data1,
            xValueMapper: (ChartData data1, _) => data1.x,
            yValueMapper: (ChartData data1, _) => data1.y),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final userInfo = Provider.of<MyUserInfo>(context);
    return FutureBuilder<List<Measurement>>(
      future: controller.getUserMeasurements(userInfo.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Scaffold(
                  body: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Logo(),
                      const GoBack(),
                      const SizedBox(
                        height: 20,
                      ),
                      createVO2Chart(snapshot.data![selectedMeasurement]),
                      panel1(snapshot.data![selectedMeasurement]),
                      panel2(snapshot.data![selectedMeasurement], context),
                      panel3(snapshot.data![selectedMeasurement], context),
                      panel4(snapshot.data![selectedMeasurement], context),
                      panel5(snapshot.data![selectedMeasurement], context),
                      panel6(snapshot.data![selectedMeasurement], context),
                      panel7(snapshot.data![selectedMeasurement]),
                      panel8(snapshot.data![selectedMeasurement]),
                    ],
                  ),
                ),
              )),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final num x;
  final num y;
}
