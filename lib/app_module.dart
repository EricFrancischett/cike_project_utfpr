import 'package:cike_project_utfpr/features/home/home_module.dart';
import 'package:cike_project_utfpr/features/login/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/home',
          module: HomeModule(),
        ),
        ModuleRoute(
          Modular.initialRoute,
          module: LoginModule(),
        )
      ];
}
