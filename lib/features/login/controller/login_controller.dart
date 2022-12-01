import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

// ignore: library_private_types_in_public_api
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {

  // @action
  // void checkIfUserIsLoggedIn() {
    // FirebaseAuth.instance.userChanges().listen((User? user) async {
    //   if (user == null) {
    //     await signInWithGoogle();
    //     await Modular.to.pushNamed('/home');
    //     debugPrint('LOGOU E FOI PRA HOME');
    //   } else {
    //     await Modular.to.pushNamed('/home');
    //     debugPrint('JA TAVA LOGADO E FOI PRA HOME');
    //   }
    // });
  // }

  // @action
//   Future<UserCredential> signInWithGoogle() async {
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
}