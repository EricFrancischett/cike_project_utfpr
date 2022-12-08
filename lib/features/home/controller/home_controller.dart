import 'dart:math';

import 'package:cike_project_utfpr/features/home/model/input_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @action
  void filterInputShowed() {
    if (pageViewIndex == 0) {
      if (filterApplied.contains('Todas')) {
        inputShowedList = inputRecomendationList;
      } else {
        inputShowedList = <InputModel>[].asObservable();
        for (var filter in filterApplied) {
          for (var input in inputRecomendationList) {
            if (!inputShowedList.contains(input) && input.type == filter) {
              inputShowedList.add(input);
            }
          }
        }
      }
      inputShowedList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
          .compareTo(b.timeAdded.millisecondsSinceEpoch));
      inputShowedList = inputShowedList.reversed.toList().asObservable();
    } else if (pageViewIndex == 1) {
      if (filterApplied.contains('Todas')) {
        inputShowedList = inputAlertList;
      } else {
        inputShowedList = <InputModel>[].asObservable();
        for (var filter in filterApplied) {
          for (var input in inputAlertList) {
            if (!inputShowedList.contains(input) && input.type == filter) {
              inputShowedList.add(input);
            }
          }
        }
      }
      inputShowedList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
          .compareTo(b.timeAdded.millisecondsSinceEpoch));
      inputShowedList = inputShowedList.reversed.toList().asObservable();
    }
  }

  @observable
  String addressFromStreetGiven = '';

  @observable
  String newInputDescription = '';

  @observable
  bool isLoading = false;

  @observable
  ObservableList<InputModel> inputRecomendationList =
      <InputModel>[].asObservable();

  @observable
  ObservableList<InputModel> inputAlertList = <InputModel>[].asObservable();

  @observable
  ObservableList<InputModel> inputShowedList = <InputModel>[].asObservable();

  @observable
  String modalDropdownSelectedValue = 'Ciclovia';

  @observable
  ObservableList<String> dropdownItensList = <String>[
    'Ciclovia',
    'Local',
    'Estacionamento',
  ].asObservable();

  @observable
  ObservableList<String> filterApplied = <String>[
    'Todas',
  ].asObservable();

  @observable
  ObservableList<String> filterList = <String>[
    'Todas',
    'Ciclovia',
    'Local',
    'Estacionamento',
  ].asObservable();

  @observable
  int mapPageViewIndex = 0;

  @observable
  int pageViewIndex = 0;

  @observable
  int bottomNavigationBarIndex = 0;

  @action
  void changeBottomNavigationBarIndex(int newIndex) {
    bottomNavigationBarIndex = newIndex;
  }

  @action
  void changePageViewIndex() {
    if (pageViewIndex == 0) {
      pageViewIndex = 1;
    } else if (pageViewIndex == 1) {
      pageViewIndex = 0;
    }
  }

  @observable
  ObservableList<Placemark> placemarks = <Placemark>[].asObservable();

  @observable
  String? currentStreet = '';

  @observable
  String? currentSubLocality = '';

  @observable
  String? currentSubAdministrativeArea = '';

  @observable
  String? currentPostalCode = '';

  @observable
  Position? currentPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  @observable
  bool serviceEnabled = false;

  @observable
  LocationPermission permission = LocationPermission.unableToDetermine;

  @action
  Future<bool> handleLocationPermission(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @action
  Future<void> getCurrentPosition(BuildContext context) async {
    isLoading = true;
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // currentPosition = position;
      currentPosition = Position(
        longitude: -49.329030,
        latitude: -25.488350,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
      );
      getAddressFromLatLng(currentPosition!);
      isLoading = false;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @action
  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentStreet = place.street;
      currentSubLocality = place.subLocality;
      currentSubAdministrativeArea = place.subAdministrativeArea;
      currentPostalCode = place.postalCode;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @action
  Future getInputs() async {
    final inputs = FirebaseFirestore.instance.collection('inputs');
    final inputListQuerySnapshot = await inputs.get();
    final inputListFromFB = inputListQuerySnapshot.docs
        .map((e) => InputModel.fromMap(e.data()))
        .toList();
    debugPrint('test');
    inputAlertList = inputListFromFB
        .where((element) => element.category == 'alert')
        .toList()
        .asObservable();
    inputAlertList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
        .compareTo(b.timeAdded.millisecondsSinceEpoch));
    inputAlertList = inputAlertList.reversed.toList().asObservable();
    inputRecomendationList = inputListFromFB
        .where((element) => element.category == 'recomendation')
        .toList()
        .asObservable();
    inputRecomendationList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
        .compareTo(b.timeAdded.millisecondsSinceEpoch));
    inputRecomendationList = inputRecomendationList.reversed.toList().asObservable();
  }

  @action
  Future addInput(int currentPageViewIndex) async {
    var rng = Random();
    var randomNumberToId = rng.nextInt(1000000000).toString();
    final collectionReference = FirebaseFirestore.instance.collection('inputs');
    await collectionReference.doc(randomNumberToId).set(
      {
        "type": modalDropdownSelectedValue,
        "timeAdded": Timestamp.now(),
        "address":
            '${currentStreet!}, ${currentSubLocality!}, ${currentSubAdministrativeArea!}',
        "description": newInputDescription,
        "id": randomNumberToId,
        "category": currentPageViewIndex == 0 ? 'recomendation' : 'alert',
        "lat": currentPosition!.latitude,
        "lgn": currentPosition!.longitude,
      },
    );
    Modular.to.pop();
    getInputs();
  }

  Future<void> addressListFromStreetGiven(String street) async {
    try {
      final locationList =
          await locationFromAddress('$street, Curitiba, Paraná, Brazil');
      for (var element in locationList) {
        final placemarkList =
            await placemarkFromCoordinates(element.latitude, element.longitude);
        final List<String> streetList = placemarkList.map((e) {
          return e.street!;
        }).toList();
        addressFromStreetGiven = streetList.first;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
