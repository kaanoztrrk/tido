import 'package:latlong2/latlong.dart';

class MarkerModel {
  final LatLng position;
  final String title;
  final String description;

  MarkerModel({
    required this.position,
    required this.title,
    required this.description,
  });
}
