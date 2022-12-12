import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class InputModel extends Equatable{
  Timestamp timeAdded;
  String type;
  String address;
  String description;
  double lat;
  double lgn;
  String category;
  String id;

  InputModel({
    required this.address,
    required this.type,
    required this.description,
    required this.category,
    required this.lat,
    required this.lgn,
    required this.id,
    required this.timeAdded,
  });

  factory InputModel.fromMap(Map<String, dynamic> map) {
    return InputModel(
      category: map['category'],
      type: map['type'],
      address: map['address'],
      lat: map['lat'],
      lgn: map['lgn'],
      description: map['description'],
      id: map['id'],
      timeAdded: map['timeAdded'],
    );
  }

  Map<String, dynamic> toMap(InputModel input) {
    return {
      'category': input.category,
      'type': input.type,
      'address': input.address,
      'lat': input.lat,
      'lgn': input.lgn,
      'description': input.description,
      'id': input.id,
      'timeAdded': input.timeAdded,
    };
  }
  
  @override
  List<Object?> get props => [id];
}
