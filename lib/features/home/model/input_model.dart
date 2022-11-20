import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InputModel extends Equatable{
  String type;
  String address;
  String description;
  double lat;
  double lgn;
  String id;

  InputModel({
    required this.address,
    required this.type,
    required this.description,
    required this.id,
    required this.lat,
    required this.lgn,
  });

  factory InputModel.fromMap(Map<String, dynamic> map) {
    return InputModel(
      id: map['id'],
      type: map['type'],
      address: map['address'],
      lat: map['lat'],
      lgn: map['lgn'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap(InputModel user) {
    return {
      'id': user.id,
      'type': user.type,
      'address': user.address,
      'lat': user.lat,
      'lgn': user.lgn,
      'description': user.description,
    };
  }

  @override
  List<Object?> get props => [id];
}
