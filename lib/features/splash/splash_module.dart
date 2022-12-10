import 'package:cike_project_utfpr/features/splash/controller/splash_controller.dart';
import 'package:cike_project_utfpr/features/splash/view/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
    Bind<SplashController>(
          (i) => SplashController(),
        ),

  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SplashPage(),
        ),
      ];
}
