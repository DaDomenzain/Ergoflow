import 'package:ergo_flow/config/color_palette.dart';
import 'package:ergo_flow/logic/measurement.dart';
import 'package:ergo_flow/logic/profile_controller.dart';
import 'package:ergo_flow/providers/user_info.dart';
import 'package:ergo_flow/screens/history/widgets/details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MeasurementHistory extends StatelessWidget {
  const MeasurementHistory({super.key});

  List<String> getMaxValuesHR(Map<String, dynamic> hr, List timestamps) {
    List<String> maxValues = [];
    List<dynamic> time = hr['time'];
    List<dynamic> value = hr['value'];

    int endRestIndex = 0;
    int endExcerciseIndex = 0;

    for (var i = 0; i < time.length; i++) {
      if (time[i] >= timestamps[0]) {
        endRestIndex = i;
        if (value.sublist(0, endRestIndex).isNotEmpty) {
          maxValues.add(value
              .sublist(0, endRestIndex)
              .reduce((curr, next) => curr > next ? curr : next)
              .round()
              .toString());
          break;
        } else {
          maxValues.add('N/A');
          break;
        }
      }
    }
    for (var i = endRestIndex; i < time.length; i++) {
      if (time[i] >= timestamps[1]) {
        endExcerciseIndex = i;
        if (value.sublist(endRestIndex, endExcerciseIndex).isNotEmpty) {
          maxValues.add(value
              .sublist(endRestIndex, endExcerciseIndex)
              .reduce((curr, next) => curr > next ? curr : next)
              .round()
              .toString());
          break;
        } else {
          maxValues.add('N/A');
          break;
        }
      }
    }

    if (value.sublist(endExcerciseIndex).isNotEmpty) {
      maxValues.add(value
          .sublist(endExcerciseIndex)
          .reduce((curr, next) => curr > next ? curr : next)
          .round()
          .toString());
    } else {
      maxValues.add('N/A');
    }

    return maxValues;
  }

  Column createMiniatureWidget(List<Measurement> measurements, int index) {
    String datetime = DateFormat('dd/MM/yyyy').format(
        DateTime.fromMillisecondsSinceEpoch(
                measurements[index].date.seconds * 1000)
            .toLocal());

    List<dynamic> vo2maxList = measurements[index].vo2['value'];
    List<String> maxHRValues =
        getMaxValuesHR(measurements[index].hr, measurements[index].timestamps);
    String maxvo2 = '';
    try {
      maxvo2 = vo2maxList
          .reduce((curr, next) => curr > next ? curr : next)
          .round()
          .toString();
    } catch (e) {
      maxvo2 = 'N/A';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text(
              'Fecha de la medición: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(datetime),
            const Spacer(),
            const Icon(Icons.navigate_next_rounded)
          ],
        ),
        const Divider(),
        const Align(
            alignment: Alignment.center,
            child: Text(
              'Datos máximos de la medición',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  maxvo2,
                  style: TextStyle(
                      color: ColorPalette.naranja,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                  'VO2 max',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          maxHRValues[0],
                          style: TextStyle(
                              color: ColorPalette.naranja,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text('Reposo', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(maxHRValues[1],
                            style: TextStyle(
                                color: ColorPalette.naranja,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const Text(
                          'Ejercicio',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Text(maxHRValues[2],
                            style: TextStyle(
                                color: ColorPalette.naranja,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const Text('Recuperación',
                            style: TextStyle(fontSize: 12))
                      ],
                    ),
                  ],
                ),
                const Text(
                  'Frecuencia cardíaca',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )
              ],
            )
          ],
        )
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
            return ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 20),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (c, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HistoryDetails(selectedMeasurement: index)),
                      );
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorPalette.blanco,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorPalette.gris2,
                              spreadRadius: 0.5,
                              blurRadius: 3,
                              offset: const Offset(
                                  1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: createMiniatureWidget(snapshot.data!, index)),
                  );
                });
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
