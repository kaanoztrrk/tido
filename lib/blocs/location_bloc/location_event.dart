import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:TiDo/data/models/markers_model/marker_model.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

// Kullanıcının mevcut konumunu alma event'i
class GetCurrentLocationEvent extends LocationEvent {}

// Kullanıcı bir marker eklediğinde tetiklenen event
class AddMarkerEvent extends LocationEvent {
  final LatLng position;
  final String title;
  final String description;

  const AddMarkerEvent({
    required this.position,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [position, title, description];
}

// Marker'ın yakınlığını kontrol eden event
class CheckMarkerProximityEvent extends LocationEvent {
  final LatLng position;

  const CheckMarkerProximityEvent(this.position);

  @override
  List<Object?> get props => [position];
}

// Kullanıcı bir arama gerçekleştirdiğinde tetiklenen event
class SearchPlacesEvent extends LocationEvent {
  final String query;

  const SearchPlacesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

// Bir lokasyona hareket etmek için event
class MoveToLocationEvent extends LocationEvent {
  final double lat;
  final double lon;

  const MoveToLocationEvent({
    required this.lat,
    required this.lon,
  });

  @override
  List<Object?> get props => [lat, lon];
}

// Marker bilgilerini göstermek için event
class ShowMarkerInfoEvent extends LocationEvent {
  final MarkerModel markerModel;

  const ShowMarkerInfoEvent(this.markerModel);

  @override
  List<Object?> get props => [markerModel];
}

// Haritaya tıklandığında yeni marker ekleme diyalogunu açan event
class ShowMarkerDialogEvent extends LocationEvent {
  final LatLng position;

  const ShowMarkerDialogEvent(this.position);

  @override
  List<Object?> get props => [position];
}

// Haritaya tıklandığında belirli bir pozisyona gitmek için event
class OnMapTapEvent extends LocationEvent {
  final LatLng position;

  const OnMapTapEvent(this.position);

  @override
  List<Object?> get props => [position];
}
