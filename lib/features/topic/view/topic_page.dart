import 'package:cike_project_utfpr/features/home/model/input_model.dart';
import 'package:cike_project_utfpr/features/topic/controller/topic_controller.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';

class TopicPage extends StatelessWidget {
  TopicPage({
    super.key,
    required this.title,
    required this.selectedInput,
    required this.currentPosition,
  });

  final String title;
  final LatLng currentPosition;
  final InputModel selectedInput;
  final controller = Modular.get<TopicController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: AppColors.white,
                        size: 28,
                      ),
                      onPressed: () {
                        Modular.to.pop();
                      },
                    ),
                  ),
                  Expanded(
                    flex: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
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
                            color: selectedInput.category == 'recomendation'
                                ? AppColors.blue
                                : AppColors.red,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: selectedInput.category == 'recomendation'
                        ? AppColors.blue
                        : AppColors.red,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedInput.type,
                      style: TextStyle(
                        color: selectedInput.category == 'recomendation'
                            ? AppColors.blue
                            : AppColors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.verified,
                      color: selectedInput.category == 'recomendation'
                          ? AppColors.blue
                          : AppColors.red,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Localização da Recomendação',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    selectedInput.address,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 224,
                    child: FlutterMap(
                      options: MapOptions(
                          onTap: (tapPosition, point) {},
                          center: currentPosition,
                          zoom: 11,
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
                              point: currentPosition,
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
                            Marker(
                              point: LatLng(
                                selectedInput.lat,
                                selectedInput.lgn,
                              ),
                              builder: (context) {
                                return InkWell(
                                  onTap: () {},
                                  child: SvgPicture.asset(
                                    IconConstants.locationMapIcon,
                                    color: selectedInput.category ==
                                            'recomendation'
                                        ? AppColors.blue
                                        : AppColors.red,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${selectedInput.timeAdded.toDate().day}/${selectedInput.timeAdded.toDate().month}/${selectedInput.timeAdded.toDate().year} às ${selectedInput.timeAdded.toDate().hour}:${selectedInput.timeAdded.toDate().minute <= 9 ? '0${selectedInput.timeAdded.toDate().minute}' : '${selectedInput.timeAdded.toDate().minute}'}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(0.05),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 26,
                ),
                child: Text(
                  selectedInput.description,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 20,
              ),
              child: Text(
                'Esta recomendação foi útil?',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.blue,
                        ),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.thumb_up,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.red,
                        ),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onPressed: () {},
                          icon: const Icon(
                            Icons.thumb_down,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
