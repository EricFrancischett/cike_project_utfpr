import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                  onTap: (tapPosition, point) {
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
                  userAgentPackageName: 'com.example.cike_project_utfpr',
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
                        return InkWell(
                          onTap: () {
                          },
                          child: SvgPicture.asset(
                            IconConstants.locationMapIcon,
                            color: AppColors.white,
                          ),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
