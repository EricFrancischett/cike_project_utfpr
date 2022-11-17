// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on _HomeControllerBase, Store {
  late final _$pageViewIndexAtom =
      Atom(name: '_HomeControllerBase.pageViewIndex', context: context);

  @override
  int get pageViewIndex {
    _$pageViewIndexAtom.reportRead();
    return super.pageViewIndex;
  }

  @override
  set pageViewIndex(int value) {
    _$pageViewIndexAtom.reportWrite(value, super.pageViewIndex, () {
      super.pageViewIndex = value;
    });
  }

  late final _$placemarksAtom =
      Atom(name: '_HomeControllerBase.placemarks', context: context);

  @override
  ObservableList<Placemark> get placemarks {
    _$placemarksAtom.reportRead();
    return super.placemarks;
  }

  @override
  set placemarks(ObservableList<Placemark> value) {
    _$placemarksAtom.reportWrite(value, super.placemarks, () {
      super.placemarks = value;
    });
  }

  late final _$currentAdressAtom =
      Atom(name: '_HomeControllerBase.currentAdress', context: context);

  @override
  String? get currentAdress {
    _$currentAdressAtom.reportRead();
    return super.currentAdress;
  }

  @override
  set currentAdress(String? value) {
    _$currentAdressAtom.reportWrite(value, super.currentAdress, () {
      super.currentAdress = value;
    });
  }

  late final _$currentPositionAtom =
      Atom(name: '_HomeControllerBase.currentPosition', context: context);

  @override
  Position? get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(Position? value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_HomeControllerBase.position', context: context);

  @override
  Position get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(Position value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$serviceEnabledAtom =
      Atom(name: '_HomeControllerBase.serviceEnabled', context: context);

  @override
  bool get serviceEnabled {
    _$serviceEnabledAtom.reportRead();
    return super.serviceEnabled;
  }

  @override
  set serviceEnabled(bool value) {
    _$serviceEnabledAtom.reportWrite(value, super.serviceEnabled, () {
      super.serviceEnabled = value;
    });
  }

  late final _$permissionAtom =
      Atom(name: '_HomeControllerBase.permission', context: context);

  @override
  LocationPermission get permission {
    _$permissionAtom.reportRead();
    return super.permission;
  }

  @override
  set permission(LocationPermission value) {
    _$permissionAtom.reportWrite(value, super.permission, () {
      super.permission = value;
    });
  }

  late final _$getPlacemarkAsyncAction =
      AsyncAction('_HomeControllerBase.getPlacemark', context: context);

  @override
  Future<void> getPlacemark() {
    return _$getPlacemarkAsyncAction.run(() => super.getPlacemark());
  }

  late final _$getPositionAsyncAction =
      AsyncAction('_HomeControllerBase.getPosition', context: context);

  @override
  Future<void> getPosition() {
    return _$getPositionAsyncAction.run(() => super.getPosition());
  }

  late final _$handleLocationPermissionAsyncAction = AsyncAction(
      '_HomeControllerBase.handleLocationPermission',
      context: context);

  @override
  Future<bool> handleLocationPermission(BuildContext context) {
    return _$handleLocationPermissionAsyncAction
        .run(() => super.handleLocationPermission(context));
  }

  late final _$getCurrentPositionAsyncAction =
      AsyncAction('_HomeControllerBase.getCurrentPosition', context: context);

  @override
  Future<void> getCurrentPosition(BuildContext context) {
    return _$getCurrentPositionAsyncAction
        .run(() => super.getCurrentPosition(context));
  }

  late final _$getAddressFromLatLngAsyncAction =
      AsyncAction('_HomeControllerBase.getAddressFromLatLng', context: context);

  @override
  Future<void> getAddressFromLatLng(Position position) {
    return _$getAddressFromLatLngAsyncAction
        .run(() => super.getAddressFromLatLng(position));
  }

  late final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase', context: context);

  @override
  void changePageViewIndex() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.changePageViewIndex');
    try {
      return super.changePageViewIndex();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pageViewIndex: ${pageViewIndex},
placemarks: ${placemarks},
currentAdress: ${currentAdress},
currentPosition: ${currentPosition},
position: ${position},
serviceEnabled: ${serviceEnabled},
permission: ${permission}
    ''';
  }
}
