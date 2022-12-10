import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'splash_controller.g.dart';

class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  @action
  Future<void> checkIfUserIsLoggedIn() async {
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
    );
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        await Modular.to.pushNamed('/login');
      } else {
        await Modular.to.pushNamed('/home');
      }
    });
  }
}
