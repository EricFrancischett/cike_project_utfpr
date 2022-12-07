import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget
    implements PreferredSizeWidget {
  CustomBottomNavigationBar({super.key});

  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.white.withOpacity(0.15),
              width: 1,
            ),
          ),
        ),
        child: Observer(
          builder: (context) => BottomNavigationBar(
            backgroundColor: AppColors.dark,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: controller.bottomNavigationBarIndex == 1
                ? controller.mapPageViewIndex == 0
                    ? AppColors.blue
                    : controller.mapPageViewIndex == 1
                        ? AppColors.red
                        : AppColors.cream
                : controller.pageViewIndex == 0
                    ? AppColors.blue
                    : controller.bottomNavigationBarIndex == 2
                        ? AppColors.blue
                        : AppColors.red,
            unselectedItemColor: AppColors.white,
            currentIndex: controller.bottomNavigationBarIndex,
            onTap: (value) => controller.changeBottomNavigationBarIndex(value),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    IconConstants.bnbItem1,
                    color: controller.bottomNavigationBarIndex == 0
                        ? controller.pageViewIndex == 0
                            ? AppColors.blue
                            : AppColors.red
                        : AppColors.white,
                  ),
                ),
                label: 'Cike',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    IconConstants.bnbItem2,
                    color: controller.bottomNavigationBarIndex == 1
                        ? controller.mapPageViewIndex == 0
                            ? AppColors.blue
                            : controller.mapPageViewIndex == 1
                                ? AppColors.red
                                : AppColors.cream
                        : AppColors.white,
                  ),
                ),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    IconConstants.bnbItem3,
                    color: controller.bottomNavigationBarIndex == 2
                        ? AppColors.blue
                        : AppColors.white,
                  ),
                ),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
