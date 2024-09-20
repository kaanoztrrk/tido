import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:TiDo/data/models/markers_model/marker_model.dart';
import '../../data/models/place_model/place_model.dart';
import 'location_event.dart';
import 'location_state.dart';
import 'package:geolocator/geolocator.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamSubscription<Position>? _positionStreamSubscription;
  LocationBloc() : super(LocationState.initial()) {
    on<GetCurrentLocationEvent>(_onGetCurrentLocation);
    on<AddMarkerEvent>(_onAddMarker);
    on<CheckMarkerProximityEvent>(_onCheckMarkerProximity);
    on<SearchPlacesEvent>(_onSearchPlaces);
    on<MoveToLocationEvent>(_onMoveToLocation);
    on<ShowMarkerInfoEvent>(_onShowMarkerInfo);
    on<ShowMarkerDialogEvent>(_onShowMarkerDialog);
    on<OnMapTapEvent>(_onMapTap);
    // Kullanıcının konumunu sürekli izlemeye başla
    _startLocationStream();
  }

  // Kullanıcının konumunu sürekli izleyen akış
  void _startLocationStream() {
    _positionStreamSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    ).listen((Position position) {
      final currentPosition = LatLng(position.latitude, position.longitude);
      add(MoveToLocationEvent(
          lat: currentPosition.latitude, lon: currentPosition.longitude));
    });
  }

  @override
  Future<void> close() {
    // Akış kapatılırken konum akışını durdur
    _positionStreamSubscription?.cancel();
    return super.close();
  }

  // Mevcut kullanıcı konumunu alma işlemi
  Future<void> _onGetCurrentLocation(
      GetCurrentLocationEvent event, Emitter<LocationState> emit) async {
    try {
      final currentPosition = await _getUserCurrentLocation(); // Konumu al
      emit(state.copyWith(currentPosition: currentPosition));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Konum alınırken bir hata oluştu'));
    }
  }

  // Yeni marker ekleme işlemi
  void _onAddMarker(AddMarkerEvent event, Emitter<LocationState> emit) {
    final newMarker = MarkerModel(
      position: event.position,
      title: event.title,
      description: event.description,
    );
    final updatedMarkers = List<MarkerModel>.from(state.markers)
      ..add(newMarker);
    emit(state.copyWith(markers: updatedMarkers));
  }

  // Marker yakınlığını kontrol etme
  void _onCheckMarkerProximity(
      CheckMarkerProximityEvent event, Emitter<LocationState> emit) {
    final isClose = _checkProximity(event.position, state.currentPosition);
    emit(state.copyWith(isMarkerClose: isClose));
  }

  // Yerleri arama işlemi
  Future<void> _onSearchPlaces(
      SearchPlacesEvent event, Emitter<LocationState> emit) async {
    try {
      final searchResults = await _searchForPlaces(event.query);
      emit(state.copyWith(searchResults: searchResults));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Arama işlemi başarısız oldu'));
    }
  }

  // Belirli bir lokasyona hareket etme
  void _onMoveToLocation(
      MoveToLocationEvent event, Emitter<LocationState> emit) {
    final newLocation = LatLng(event.lat, event.lon);
    emit(state.copyWith(currentPosition: newLocation));
  }

  // Marker bilgilerini gösterme
  void _onShowMarkerInfo(
      ShowMarkerInfoEvent event, Emitter<LocationState> emit) {
    emit(state.copyWith(selectedMarker: event.markerModel));
  }

  // Marker ekleme diyalogunu gösterme
  void _onShowMarkerDialog(
      ShowMarkerDialogEvent event, Emitter<LocationState> emit) {
    emit(state.copyWith(
        showMarkerDialog: true, markerDialogPosition: event.position));
  }

  // Haritaya tıklama işlemi
  void _onMapTap(OnMapTapEvent event, Emitter<LocationState> emit) {
    emit(state.copyWith(mapTappedPosition: event.position));
  }

  // İsteğe bağlı olarak başlangıçta yapılacak işlemler
  Future<void> _loadInitialLocation() async {
    add(GetCurrentLocationEvent());
  }

  // Kullanıcının mevcut konumunu alacak fonksiyon
  Future<LatLng> _getUserCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      throw Exception('Konum alınırken bir hata oluştu');
    }
  }

  // Marker yakınlığı kontrolü
  bool _checkProximity(LatLng markerPosition, LatLng? currentPosition) {
    if (currentPosition == null) return false;
    final distance = const Distance().as(
      LengthUnit.Meter,
      markerPosition,
      currentPosition,
    );
    return distance < 100; // Örneğin 100 metre yakınlık
  }

  Future<List<PlaceModel>> _searchForPlaces(String query) async {
    // Gerçek bir arama motoru API çağrısı burada olabilir
    // Şu an için sahte bir veri döndürüyoruz
    return [];
  }
}
