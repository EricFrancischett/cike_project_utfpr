import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (context) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _controller.currentStreet!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Transform.rotate(
                    angle: -pi * 1 / 2,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: _controller.pageViewIndex == 0
                          ? AppColors.blue
                          : AppColors.red,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 33,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Recomendações",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _controller.pageViewIndex == 0
                                  ? AppColors.blue
                                  : AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: _controller.pageViewIndex == 0
                                  ? AppColors.blue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 5,
                    ),
                    Expanded(
                      flex: 15,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Alertas",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _controller.pageViewIndex == 1
                                  ? AppColors.red
                                  : AppColors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              color: _controller.pageViewIndex == 1
                                  ? AppColors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(
                      flex: 26,
                    ),
                    Expanded(
                      flex: 10,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: (() {
                          _controller.changePageViewIndex();
                        }),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: _controller.pageViewIndex == 0
                                ? AppColors.blue
                                : AppColors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: AppColors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: AppColors.white,
              ),
              Center(
                child: Column(
                  children: [
                    Flexible(child: Container(
                      color: AppColors.blue,
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
