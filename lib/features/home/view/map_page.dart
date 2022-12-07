import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/features/home/widgets/home_modal.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Modular.get<HomeController>();
    return Observer(
      builder: (context) => SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: AppColors.dark,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${controller.currentStreet!}, ${controller.currentSubLocality!}, ${controller.currentSubAdministrativeArea!}',
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
                          color: controller.mapPageViewIndex == 0
                              ? AppColors.blue
                              : controller.mapPageViewIndex == 1
                                  ? AppColors.red
                                  : AppColors.cream,
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
                          child: InkWell(
                            onTap: () {
                              controller.mapPageViewIndex = 0;
                              controller.filterInputShowed();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Recomendações",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: controller.mapPageViewIndex == 0
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
                                    color: controller.mapPageViewIndex == 0
                                        ? AppColors.blue
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 5,
                        ),
                        Expanded(
                          flex: 15,
                          child: InkWell(
                            onTap: () {
                              controller.mapPageViewIndex = 1;
                              controller.filterInputShowed();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Alertas",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: controller.mapPageViewIndex == 1
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
                                    color: controller.mapPageViewIndex == 1
                                        ? AppColors.red
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 5,
                        ),
                        Expanded(
                          flex: 15,
                          child: InkWell(
                            onTap: () {
                              controller.mapPageViewIndex = 2;
                              controller.filterInputShowed();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Todos",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: controller.mapPageViewIndex == 2
                                        ? AppColors.cream
                                        : AppColors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Container(
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: controller.mapPageViewIndex == 2
                                        ? AppColors.cream
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(
                          flex: 6,
                        ),
                        Expanded(
                          flex: 10,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: (() {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return HomeModal();
                                },
                              ).then((value) async {
                                await Future.delayed(
                                  const Duration(
                                    milliseconds: 750,
                                  ),
                                );
                                controller.filterInputShowed();
                              });
                            }),
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: controller.mapPageViewIndex == 0
                                    ? AppColors.blue
                                    : controller.mapPageViewIndex == 1
                                        ? AppColors.red
                                        : AppColors.cream,
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
                ],
              ),
            ),
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                    onTap: (tapPosition, point) {},
                    center: LatLng(
                      controller.currentPosition!.latitude,
                      controller.currentPosition!.longitude,
                    ),
                    zoom: 13,
                    maxZoom: 18),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png",
                    userAgentPackageName: 'com.example.cike_project_utfpr',
                    subdomains: const ['a', 'b', 'c'],
                    errorImage: const NetworkImage(
                        'https://tile.openstreetmap.org/18/0/0.png'),
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: LatLng(
                          controller.currentPosition!.latitude,
                          controller.currentPosition!.longitude,
                        ),
                        builder: (context) {
                          return InkWell(
                            onTap: () {},
                            child: SvgPicture.asset(
                              IconConstants.locationMapIcon,
                              color: AppColors.white,
                            ),
                          );
                        },
                      ),
                      if (controller.mapPageViewIndex == 0 ||
                          controller.mapPageViewIndex == 2) ...{
                        ...controller.inputRecomendationList
                            .map(
                              (element) => Marker(
                                point: LatLng(element.lat, element.lgn),
                                builder: (context) {
                                  return InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      IconConstants.locationMapIcon,
                                      color: AppColors.blue,
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList()
                      },
                      if (controller.mapPageViewIndex == 1 ||
                          controller.mapPageViewIndex == 2) ...{
                        ...controller.inputAlertList
                            .map(
                              (element) => Marker(
                                point: LatLng(element.lat, element.lgn),
                                builder: (context) {
                                  return InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      IconConstants.locationMapIcon,
                                      color: AppColors.red,
                                    ),
                                  );
                                },
                              ),
                            )
                            .toList()
                      }
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
