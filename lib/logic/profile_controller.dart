// ignore_for_file: unnecessary_null_comparison

import 'package:ergo_flow/logic/auth.dart';
import 'package:ergo_flow/logic/user.dart';
import 'package:ergo_flow/logic/user_repository.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    print(email);
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      //Get.snackbar('Error', 'Login to continue');
    }
  }

  updateRecord(FBUser user) async {
    await _userRepo.updateUserRecord(user);
  }
}
