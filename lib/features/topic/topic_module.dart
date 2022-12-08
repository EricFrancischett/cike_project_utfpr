import 'package:cike_project_utfpr/features/topic/view/topic_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'controller/topic_controller.dart';

class TopicModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<TopicController>(
          (i) => TopicController(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => TopicPage(
            title: args.data['title'],
            selectedInput: args.data['selectedInput'],
          ),
        ),
      ];
}
