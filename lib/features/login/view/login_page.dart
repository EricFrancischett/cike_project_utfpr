import 'package:cike_project_utfpr/features/login/controller/login_controller.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Modular.get<LoginController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 26,
              child: SizedBox(
                child: Center(
                  child: SvgPicture.asset(
                    IconConstants.loginLogo,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 74,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      const Color(0xFF2E282A)
                          .withOpacity(0.45)
                          .withBlue(255)
                          .withGreen(255),
                      BlendMode.multiply,
                    ),
                    fit: BoxFit.cover,
                    image: const AssetImage('assets/login_background.png'),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 56),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: SvgPicture.asset(
                                IconConstants.loginSubtitle,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  await controller.signInAnonymously();
                                  Modular.to.pushReplacementNamed('/home/');
                                },
                                child: const Text(
                                  'Continue como convidado',
                                  style: TextStyle(
                                    color: AppColors.dark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 40,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                    AppColors.white,
                                  ),
                                ),
                                onPressed: () async {
                                  // await controller.signInWithGoogle();
                                  Modular.to.pushReplacementNamed('/home/');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      IconConstants.googleLogo,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Text(
                                      'Continue com o Google',
                                      style: TextStyle(
                                        color: AppColors.dark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: const [
                                  Text(
                                    'Não tem uma conta?',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Cadastre-se',
                                    style: TextStyle(
                                      color: AppColors.lightPink,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
