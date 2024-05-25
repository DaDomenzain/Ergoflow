import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ergo_flow/logic/measurement.dart';
import 'package:ergo_flow/logic/user.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  createUser(FBUser user) async {
    await _db.collection('users').add(user.toJson()).whenComplete(() {
      Get.snackbar('Success', 'Your account has been created');
      // ignore: body_might_complete_normally_catch_error
    }).catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong. Please try again');
    });
  }

  Future<FBUser> getUserDetails(String email) async {
    final snapshot =
        await _db.collection('users').where('email', isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => FBUser.fromSnapshot(e)).single;
    return userData;
  }

  Future<void> updateUserRecord(FBUser user) async {
    await _db.collection('users').doc(user.id).update(user.toJson());
  }

  createMeasurementRecord(String? id, Measurement measurement) async {
    await _db
        .collection('users')
        .doc(id)
        .collection('records')
        .add(measurement.toJson())
        .whenComplete(() {
      Get.snackbar('Success', 'Your account has been created');
      // ignore: body_might_complete_normally_catch_error
    }).catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong. Please try again');
    });
  }
}
