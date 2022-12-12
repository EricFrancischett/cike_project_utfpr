import 'package:cike_project_utfpr/features/home/model/input_model.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:cike_project_utfpr/general/icon_constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputCard extends StatelessWidget {
  final int pageViewIndex;
  final InputModel input;
  final Function() onTap;
  const InputCard({
    super.key,
    required this.pageViewIndex,
    required this.input,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 72,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (input.type == 'Ciclovia') ...{
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset(
                        pageViewIndex == 0
                            ? IconConstants.bikeBlue
                            : IconConstants.bikeRed,
                        fit: BoxFit.none,
                      ),
                    ),
                  } else if (input.type == 'Local') ...{
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset(
                        pageViewIndex == 0
                            ? IconConstants.locationBlue
                            : IconConstants.locationRed,
                        fit: BoxFit.none,
                      ),
                    ),
                  } else if (input.type == 'Estacionamento') ...{
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: SvgPicture.asset(
                        pageViewIndex == 0
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
                          input.type,
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
                          input.address,
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
                    color: pageViewIndex == 0 ? AppColors.blue : AppColors.red,
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
    );
  }
}
