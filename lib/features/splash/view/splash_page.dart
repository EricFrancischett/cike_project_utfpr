import 'package:cike_project_utfpr/features/splash/controller/splash_controller.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Modular.get<SplashController>();

  @override
  void initState() {
    splashSetup();
    super.initState();
  }

  splashSetup() async {
    await controller.checkIfUserIsLoggedIn();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SizedBox(
        child: Center(
          child: SvgPicture.asset(
            IconConstants.loginLogo,
          ),
        ),
      ),
    );
  }
}
