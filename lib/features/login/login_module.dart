import 'package:cike_project_utfpr/features/login/controller/login_controller.dart';
import 'package:cike_project_utfpr/features/login/view/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
    Bind<LoginController>(
          (i) => LoginController(),
        ),

  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const LoginPage(),
        ),
      ];
}
