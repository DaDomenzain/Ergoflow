//variables de mas de una palabra no van con guion bajo, van con la primera palabra en minusculas, pegada a la segunda, pero esta inicia con mayuscula: ejemplo: displayMessagetoUser
//@Domenzain con OCT

import 'package:flutter/material.dart';
import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';

double flujoEspiraciones(List<double> pressVals, double timeEsp) {
  double alpha = 0.2361;
  List<double> volEsp = [];
  List<double> timeList = [];
  double volFlow;
  List<double> promO2 = [];
  List<double> promCo2 = [];
  List<double> promTemp = [];

  int lenPress = 0;

  pressVals = pressVals.map((e) => e * alpha).toList();
  lenPress = pressVals.length;
  timeList.add(timeEsp);

  if (lenPress == 1) {
    pressVals.add(pressVals[0]);
    lenPress = pressVals.length;
  }

  //integración

  volEsp = cumIntegration(Array(pressVals)).toList();
  volFlow = (volEsp.reduce(max));
  return volFlow;
}

double vo2Max(double co2Val, double temp, double o2Val, double volFlow,
    double elapsedTime, double weight) {
  double fiN2 = 0.7808; //0.7904

  double volMinute = volFlow * 60 / elapsedTime;
  co2Val = co2Val / 10000;
  double viHaldane = (1 - co2Val / 100 - o2Val / 100) / fiN2;
  double ve = volMinute * (273.15 / (273.15 + temp)) * ((760.0 - 25.2) / 760);
  double vMax = ve * (((viHaldane / 100) * 0.209) - (o2Val / 100));
  vMax = ((vMax * 100).abs()) / (weight / 2.2);

  return vMax;
}

int heartRate(List<double> hrSignal) {
  var peaks = findPeaks(Array(hrSignal), threshold: 2.01);
  int beats = peaks[1].length();
  int bpm = (60 * beats / 5).round(); //5 es el valor del tiempo que ha pasado -
  //este valor depende de como pongamos el código en chart.dart
  return bpm;
}
