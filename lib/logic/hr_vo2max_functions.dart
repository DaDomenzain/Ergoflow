//variables de mas de una palabra no van con guion bajo, van con la primera palabra en minusculas, pegada a la segunda, pero esta inicia con mayuscula: ejemplo: displayMessagetoUser
//@Domenzain con OCT

import 'package:scidart/numdart.dart';
import 'package:scidart/scidart.dart';

double flujoEspiraciones(List<double> pressVals) {
  double alpha = 0.2361;
  List<double> volEsp = [];
  double volFlow;

  int lenPress = 0;

  pressVals = pressVals.map((e) => e * alpha).toList();
  lenPress = pressVals.length;

  if (lenPress == 1) {
    pressVals.add(pressVals[0]);
    lenPress = pressVals.length;
  }

  //integración

  volEsp = cumIntegration(Array(pressVals)).toList();
  volFlow = (volEsp.reduce(max));
  return volFlow;
}

(double, double, double, double) vo2Max(double co2Val, double temp,
    double o2Val, double volFlow, double elapsedTime, int weight) {
  double fiN2 = 0.7808; //0.7904

  double volMinute = volFlow * 60 / elapsedTime;
  co2Val = co2Val / 10000; //porcentaje de co2
  double viHaldane = (1 - co2Val / 100 - o2Val / 100) / fiN2;
  double ve = volMinute * (273.15 / (273.15 + temp)) * ((760.0 - 25.2) / 760);
  double vMax = ve * ((viHaldane * 0.209) - (o2Val / 100));
  double coMax = ve * ((co2Val / 100) - (viHaldane * 0.0003));
  vMax = ((vMax * 1000).abs()) / (weight);
  coMax = ((coMax * 1000).abs()) / (weight);

  return (vMax, coMax, ve, volFlow);
}

int heartRate(List<double> hrSignal) {
  //print(hrSignal);
  var peaks = findPeaks(Array(hrSignal), threshold: 1);
  //print(peaks);
  Array newPeaks = peaks[1];
  //print(newPeaks);
  for (var i = 0; i < newPeaks.length - 1; i++) {
    if (newPeaks[i] == newPeaks[i + 1]) {
      newPeaks.removeAt(i);
    }
  }
  //print(newPeaks);
  int beats = newPeaks.length;
  int bpm = (60 * beats / 5).round(); //5 es el valor del tiempo que ha pasado -
  //este valor depende de como pongamos el código en chart.dart
  return bpm;
}
