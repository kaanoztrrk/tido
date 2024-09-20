import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String? placeId; // Opsiyonel bir alan olabilir
  final String? description; // Opsiyonel bir açıklama alanı olabilir

  const PlaceModel({
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.placeId,
    this.description,
  });

  @override
  List<Object?> get props =>
      [name, address, latitude, longitude, placeId, description];

  // JSON serialize ve deserialize için yardımcı fonksiyonlar

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      name: json['name'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      placeId: json['place_id'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'place_id': placeId,
      'description': description,
    };
  }
}
