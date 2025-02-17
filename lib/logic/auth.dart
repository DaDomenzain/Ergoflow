import 'package:ergo_flow/logic/user.dart';
import 'package:ergo_flow/logic/user_repository.dart';
import 'package:ergo_flow/screens/login/login.dart';
import 'package:ergo_flow/screens/splash_screen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const Login())
        : Get.offAll(() => const SplashScreen());
  }

  Future<void> createUserWithEmailandPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = FBUser(
          id: '1234',
          email: email,
          name: 'Usuario',
          age: 1,
          sex: 'Masculino',
          height: 1,
          weight: 1,
          avatar: 'assets/images/1.jpg');
      UserRepository().createUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Correo ya está en uso');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'Correo inválido');
      } else if (e.code == 'weak-password') {
        Get.snackbar('Error', 'Contraseña muy débil');
      } else {
        Get.snackbar('Error', 'Algo salió mal. Intenta de nuevo.');
      }
    } catch (_) {}
  }

  Future<void> loginWithEmailandPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      Get.snackbar('Error', 'Usuario o contraseña incorrecta');
    } catch (_) {}
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      var result = await FirebaseAuth.instance.signInWithCredential(credential);
      if (result.additionalUserInfo!.isNewUser) {
        final user = FBUser(
            id: '1234',
            email: googleUser!.email,
            name: 'Usuario',
            age: 1,
            sex: 'Masculino',
            height: 1,
            weight: 1,
            avatar: 'assets/images/1.jpg');
        UserRepository().createUser(user);
      } else {
        return result;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Correo ya está en uso');
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Error', 'Correo inválido');
      } else if (e.code == 'weak-password') {
        Get.snackbar('Error', 'Contraseña muy débil');
      } else {
        Get.snackbar('Error', 'Algo salió mal. Intenta de nuevo.');
      }
    } catch (_) {}
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
