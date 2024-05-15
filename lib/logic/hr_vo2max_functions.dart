//variables de mas de una palabra no van con guion bajo, van con la primera palabra en minusculas, pegada a la segunda, pero esta inicia con mayuscula: ejemplo: displayMessagetoUser
//@Domenzain con OCT

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
