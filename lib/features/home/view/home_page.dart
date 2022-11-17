import 'dart:math';

import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
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
          child: BottomNavigationBar(
            backgroundColor: AppColors.dark,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: AppColors.white,
            unselectedItemColor: AppColors.blue,
            currentIndex: _controller.bottomNavigationBarIndex,
            onTap: (value) => setState(() {
              _controller.changeBottomNavigationBarIndex(value);
            }),
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    IconConstants.bnbItem1,
                    color: _controller.bottomNavigationBarIndex == 0
                        ? AppColors.white
                        : AppColors.blue,
                  ),
                ),
                label: 'Cike',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    IconConstants.bnbItem2,
                    color: _controller.bottomNavigationBarIndex == 1
                        ? AppColors.white
                        : AppColors.blue,
                  ),
                ),
                label: 'Mapa',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    IconConstants.bnbItem3,
                    color: _controller.bottomNavigationBarIndex == 2
                        ? AppColors.white
                        : AppColors.blue,
                  ),
                ),
                label: 'Perfil',
              ),
            ],
          ),
        ),
      ),
      backgroundColor: AppColors.dark,
      body: SafeArea(
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
                      _controller.currentAdress!,
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
                    )
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
                      itemCount: _controller.filterList.length,
                      itemBuilder: ((context, index) => Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _controller.pageViewIndex == 0
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
                                    _controller.filterList[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: _controller.pageViewIndex == 0
                                          ? AppColors.blue
                                          : AppColors.red,
                                    ),
                                  ),
                                ),
                              ),
                              if (index !=
                                  _controller.filterList.length - 1) ...{
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                                    -25.488350,
                                    -49.329030,
                                  ),
                                  builder: (context) => InkWell(
                                    onTap: () {
                                      debugPrint("teste");
                                    },
                                    child: SvgPicture.asset(
                                      IconConstants.locationMapIcon,
                                      color: AppColors.red,
                                    ),
                                  ),
                                ),
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
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 72,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_controller.inputList[index].type ==
                                  'Ciclovia') ...{
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(
                                    _controller.pageViewIndex == 0
                                        ? IconConstants.bikeBlue
                                        : IconConstants.bikeRed,
                                    fit: BoxFit.none,
                                  ),
                                ),
                              } else if (_controller.inputList[index].type ==
                                  'Local') ...{
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(
                                    _controller.pageViewIndex == 0
                                        ? IconConstants.locationBlue
                                        : IconConstants.locationRed,
                                    fit: BoxFit.none,
                                  ),
                                ),
                              } else if (_controller.inputList[index].type ==
                                  'Estacionamento') ...{
                                SizedBox(
                                  height: 40,
                                  width: 40,
                                  child: SvgPicture.asset(
                                    _controller.pageViewIndex == 0
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _controller.inputList[index].type,
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
                                      _controller.inputList[index].adress,
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
                                color: _controller.pageViewIndex == 0
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
                  itemCount: _controller.inputList.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
