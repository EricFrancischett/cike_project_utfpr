import 'package:equatable/equatable.dart';

class InputModel extends Equatable{
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
    );
  }

  Map<String, dynamic> toMap(InputModel user) {
    return {
      'category': user.category,
      'type': user.type,
      'address': user.address,
      'lat': user.lat,
      'lgn': user.lgn,
      'description': user.description,
      'id': user.id,
    };
  }
  
  @override
  List<Object?> get props => [id];

}
