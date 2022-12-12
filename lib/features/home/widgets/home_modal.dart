import 'dart:math';
import 'package:cike_project_utfpr/features/home/controller/home_controller.dart';
import 'package:cike_project_utfpr/general/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModal extends StatelessWidget {
  HomeModal({super.key});

  final controller = Modular.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: () {
                      Modular.to.pop();
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.cream,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text(
                      controller.pageViewIndex == 0
                          ? 'Nova Recomendação'
                          : 'Novo Alerta',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            const Text(
              'Tipo de recomendação',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 47,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ButtonTheme(
                alignedDropdown: true,
                child: Observer(
                  builder: (context) => DropdownButton<String>(
                    borderRadius: BorderRadius.circular(8),
                    icon: Transform.rotate(
                      angle: -pi * 1 / 2,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.dark,
                          size: 16,
                        ),
                      ),
                    ),
                    isExpanded: true,
                    underline: const SizedBox(),
                    onChanged: ((value) {
                      controller.modalDropdownSelectedValue = value!;
                    }),
                    value: controller.modalDropdownSelectedValue,
                    items: controller.dropdownItensList
                        .map(
                          (element) => DropdownMenuItem<String>(
                            value: element,
                            child: Text(
                              element,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.dark,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Localização de recomendação',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.white,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              height: 47,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Observer(
                  builder: (context) => TextField(
                    readOnly: true,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.dark,
                    ),
                    decoration: InputDecoration(
                      hintText: controller.currentStreet!,
                      border: InputBorder.none,
                    ),
                    cursorColor: AppColors.dark,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              height: 47,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Expanded(
                      child: Text(
                        'Descreva o alerta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                    Observer(
                      builder: (context) => Text(
                        (400 - controller.newInputDescription.length)
                            .toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.dark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 2.2,
            ),
            Container(
              height: 114,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  onChanged: (value) {
                    controller.newInputDescription = value;
                  },
                  maxLength: 400,
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                  decoration: const InputDecoration(
                    counter: SizedBox(),
                    border: InputBorder.none,
                  ),
                  cursorColor: AppColors.dark,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(
                    controller.pageViewIndex == 0
                        ? AppColors.blue
                        : AppColors.red,
                  ),
                ),
                onPressed: () {
                  if (controller.newInputDescription != '') {
                    controller.addInput(controller.pageViewIndex);
                    controller.filterInputShowed();
                  }
                },
                child: Text(
                  controller.pageViewIndex == 0
                      ? 'Publicar Recomendação'
                      : 'Publicar Alerta',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }
}
