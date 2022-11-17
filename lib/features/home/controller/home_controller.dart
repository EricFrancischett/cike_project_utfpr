import 'package:cike_project_utfpr/features/home/model/input_model.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  ObservableList<InputModel> inputList = <InputModel>[
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Local',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Estacionamento',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
    InputModel(
        type: 'Ciclovia',
        adress: 'Rua Deputado Heitor Alencar Furtado, 5000',
        description:
            'Ciclovia muito boa de andar, iluminada e sem risco de colisões com os carros.'),
  ].asObservable();

  @observable
  ObservableList<String> filterList = <String>[
    'Todas',
    'Ciclovias',
    'Locais',
    'Estacionamentos',
    'Prática em Grupo',
  ].asObservable();

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
  String? currentAdress = 'Av. Sete de Setembro, 3165';

  @observable
  Position? currentPosition = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  @observable
  Position position = Position(
      longitude: 0,
      latitude: 0,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0);

  @observable
  bool serviceEnabled = false;

  @observable
  LocationPermission permission = LocationPermission.unableToDetermine;

  @action
  Future<void> getPlacemark() async {
    List<Placemark> placemarksList =
        await placemarkFromCoordinates(52.2165157, 6.9437819);
    placemarks = placemarksList.asObservable();
  }

  @action
  Future<void> getPosition() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @action
  Future<bool> handleLocationPermission(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
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
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
    }).catchError((e) {
      debugPrint(e);
    });
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      getAddressFromLatLng(currentPosition!);
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
      currentAdress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
