import 'package:cloud_firestore/cloud_firestore.dart';

class Measurement {
  Map<String, dynamic> vo2;
  Map<String, dynamic> vco2;
  Map<String, dynamic> ve;
  Map<String, dynamic> vt;
  Map<String, dynamic> hr;
  Timestamp date;
  List<dynamic> timestamps;

  Measurement(
      {required this.vo2,
      required this.vco2,
      required this.ve,
      required this.vt,
      required this.hr,
      required this.date,
      required this.timestamps});

  Map<String, dynamic> toJson() => {
        'vo2': vo2,
        'vco2': vco2,
        've': ve,
        'vt': vt,
        'hr': hr,
        'date': date,
        'timestamps': timestamps
      };

  factory Measurement.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    Measurement a = Measurement(
        vo2: data['vo2'],
        vco2: data['vco2'],
        ve: data['ve'],
        vt: data['vt'],
        hr: data['hr'],
        date: data['date'],
        timestamps: data['timestamps']);
    return a;
  }
}
