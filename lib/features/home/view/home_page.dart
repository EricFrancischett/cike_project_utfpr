import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/features/home/view/cike_page.dart';
import 'package:cike_project_utfpr/features/home/view/map_page.dart';
import 'package:cike_project_utfpr/features/home/view/profile_page.dart';
import 'package:cike_project_utfpr/features/home/widgets/custom_bottom_navigation_bar.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = Modular.get<HomeController>();

  @override
  void initState() {
    cikePageSetup();
    super.initState();
  }

  Future<void> cikePageSetup() async {
    await controller.getCurrentPosition(context);
    await controller.getInputs();
    controller.filterInputShowed();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const CikePage(),
      const MapPage(),
      const ProfilePage(),
    ];

    return Observer(builder: (_) {
      return Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(),
          backgroundColor: AppColors.dark,
          body: pages[controller.bottomNavigationBarIndex]);
    });
  }
}
