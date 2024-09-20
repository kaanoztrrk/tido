import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';
import 'package:TiDo/data/models/markers_model/marker_model.dart';

import '../../data/models/place_model/place_model.dart';

class LocationState extends Equatable {
  final LatLng? currentPosition;
  final List<MarkerModel> markers;
  final bool isMarkerClose;
  final MarkerModel? selectedMarker;
  final bool showMarkerDialog;
  final LatLng? markerDialogPosition;
  final LatLng? mapTappedPosition;
  final List<PlaceModel>? searchResults; // Yeni alan
  final String? errorMessage;

  const LocationState({
    this.currentPosition,
    this.markers = const [],
    this.isMarkerClose = false,
    this.selectedMarker,
    this.showMarkerDialog = false,
    this.markerDialogPosition,
    this.mapTappedPosition,
    this.searchResults = const [],
    this.errorMessage,
  });

  LocationState copyWith({
    LatLng? currentPosition,
    List<MarkerModel>? markers,
    bool? isMarkerClose,
    MarkerModel? selectedMarker,
    bool? showMarkerDialog,
    LatLng? markerDialogPosition,
    LatLng? mapTappedPosition,
    List<PlaceModel>? searchResults, // Yeni alan
    String? errorMessage,
  }) {
    return LocationState(
      currentPosition: currentPosition ?? this.currentPosition,
      markers: markers ?? this.markers,
      isMarkerClose: isMarkerClose ?? this.isMarkerClose,
      selectedMarker: selectedMarker ?? this.selectedMarker,
      showMarkerDialog: showMarkerDialog ?? this.showMarkerDialog,
      markerDialogPosition: markerDialogPosition ?? this.markerDialogPosition,
      mapTappedPosition: mapTappedPosition ?? this.mapTappedPosition,
      searchResults: searchResults ?? this.searchResults, // Yeni alan
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentPosition,
        markers,
        isMarkerClose,
        selectedMarker,
        showMarkerDialog,
        markerDialogPosition,
        mapTappedPosition,
        searchResults, // Yeni alan
        errorMessage,
      ];

  // Initial state
  factory LocationState.initial() {
    return const LocationState(
      currentPosition: null,
      markers: [],
      isMarkerClose: false,
      selectedMarker: null,
      showMarkerDialog: false,
      markerDialogPosition: null,
      mapTappedPosition: null,
      searchResults: [], // Yeni alan
      errorMessage: null,
    );
  }
}
