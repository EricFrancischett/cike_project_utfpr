import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/features/home/view/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
    Bind<HomeController>(
          (i) => HomeController(),
        ),

  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => HomePage(),
        ),
      ];
}
