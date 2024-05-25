import 'package:cloud_firestore/cloud_firestore.dart';

class Measurement {
  Map<String, List> vo2;
  Map<String, List> hr;
  FieldValue date;

  Measurement({required this.vo2, required this.hr, required this.date});

  Map<String, dynamic> toJson() => {
        'vo2': vo2,
        'hr': hr,
        'date': date,
      };

  factory Measurement.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Measurement(
      vo2: data['vo2'],
      hr: data['hr'],
      date: data['date'],
    );
  }
}
