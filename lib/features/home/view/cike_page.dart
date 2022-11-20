import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/features/home/widgets/home_modal.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

class CikePage extends StatelessWidget {
  CikePage({
    super.key,
  });

  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => controller.isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.blue,
              ),
            )
          : SafeArea(
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
                            controller.currentStreet!,
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
                              color: controller.pageViewIndex == 0
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
                                      color: controller.pageViewIndex == 0
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
                                      color: controller.pageViewIndex == 0
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
                                      color: controller.pageViewIndex == 1
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
                                      color: controller.pageViewIndex == 1
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
                                  showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return HomeModal();
                                    },
                                  );
                                }),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: controller.pageViewIndex == 0
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
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: SizedBox(
                          height: 34,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: controller.filterList.length,
                            itemBuilder: ((context, index) => Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: controller.pageViewIndex == 0
                                              ? AppColors.blue
                                              : AppColors.red,
                                          width: 2,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          controller.filterList[index],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: controller.pageViewIndex == 0
                                                ? AppColors.blue
                                                : AppColors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (index !=
                                        controller.filterList.length - 1) ...{
                                      const SizedBox(
                                        width: 16,
                                      )
                                    }
                                  ],
                                )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Perto de você',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 224,
                              child: FlutterMap(
                                options: MapOptions(
                                    onTap: (tapPosition, point) {
                                      debugPrint(point.latitude.toString());
                                      debugPrint(point.longitude.toString());
                                    },
                                    center: LatLng(
                                      // controller.currentPosition!.latitude,
                                      // controller.currentPosition!.longitude,
                                      -25.488350,
                                      -49.329030,
                                    ),
                                    zoom: 13,
                                    maxZoom: 18),
                                children: [
                                  TileLayer(
                                    urlTemplate:
                                        "https://cartodb-basemaps-{s}.global.ssl.fastly.net/dark_all/{z}/{x}/{y}.png",
                                    userAgentPackageName:
                                        'com.example.cike_project_utfpr',
                                    subdomains: const ['a', 'b', 'c'],
                                    errorImage: const NetworkImage(
                                        'https://tile.openstreetmap.org/18/0/0.png'),
                                  ),
                                  MarkerLayer(
                                    markers: [
                                      Marker(
                                        point: LatLng(
                                          // controller.currentPosition!.latitude,
                                          // controller.currentPosition!.longitude,
                                          -25.488350,
                                          -49.329030,
                                        ),
                                        builder: (context) {
                                          debugPrint('buildou');
                                          return InkWell(
                                            onTap: () {
                                              debugPrint("teste");
                                            },
                                            child: SvgPicture.asset(
                                              IconConstants.locationMapIcon,
                                              color: AppColors.white,
                                            ),
                                          );
                                        },
                                      ),
                                      ...controller.inputList
                                          .map((element) => Marker(
                                                point: LatLng(
                                                    element.lat, element.lgn),
                                                builder: (context) {
                                                  debugPrint('buildou');
                                                  return InkWell(
                                                    onTap: () {
                                                      debugPrint("teste");
                                                    },
                                                    child: SvgPicture.asset(
                                                      IconConstants
                                                          .locationMapIcon,
                                                      color: controller
                                                                  .pageViewIndex ==
                                                              0
                                                          ? AppColors.blue
                                                          : AppColors.red,
                                                    ),
                                                  );
                                                },
                                              ))
                                          .toList(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ListView.builder(
                        itemCount: controller.inputList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: 72,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (controller.inputList[index].type ==
                                        'Ciclovia') ...{
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: SvgPicture.asset(
                                          controller.pageViewIndex == 0
                                              ? IconConstants.bikeBlue
                                              : IconConstants.bikeRed,
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    } else if (controller
                                            .inputList[index].type ==
                                        'Local') ...{
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: SvgPicture.asset(
                                          controller.pageViewIndex == 0
                                              ? IconConstants.locationBlue
                                              : IconConstants.locationRed,
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    } else if (controller
                                            .inputList[index].type ==
                                        'Estacionamento') ...{
                                      SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: SvgPicture.asset(
                                          controller.pageViewIndex == 0
                                              ? IconConstants.parkBlue
                                              : IconConstants.parkRed,
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    },
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.inputList[index].type,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            controller.inputList[index].address,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                              color: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: controller.pageViewIndex == 0
                                          ? AppColors.blue
                                          : AppColors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: AppColors.white.withOpacity(0.15),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
