import 'dart:convert';
import 'package:TiDo/common/widget/appbar/appbar.dart';
import 'package:TiDo/data/models/markers_model/marker_model.dart';
import 'package:TiDo/utils/Constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class LocationReminderView extends StatefulWidget {
  const LocationReminderView({super.key});

  @override
  _LocationReminderViewState createState() => _LocationReminderViewState();
}

class _LocationReminderViewState extends State<LocationReminderView> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<MarkerModel> _markerModel = [];
  List<Marker> _markerks = [];
  LatLng? _selectedPosition;
  LatLng? _myLocation;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Konum servisleri kapalı.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Konum izni reddedildi.');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Konum izni kalıcı olarak reddedildi, ayarlardan izin verilmelidir.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _myLocation = LatLng(position.latitude, position.longitude);
      _currentLocation = _myLocation;
    });

    // Kullanıcının konumu güncellendiğinde marker'larla temayı kontrol et
    for (final marker in _markerModel) {
      _checkMarkerProximity(marker.position);
    }

    _mapController.move(_currentLocation!, 15.0);
  }

  void _addMarker(LatLng position, String title, String description) {
    setState(() {
      final markerModel = MarkerModel(
        position: position,
        title: title,
        description: description,
      );
      _markerModel.add(markerModel);
      _markerks.add(
        Marker(
          point: position,
          width: 80,
          height: 80,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => showMarkerInfo(markerModel),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Iconsax.location,
                  color: Colors.redAccent,
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      );

      // Marker eklendikten sonra konumlar arasındaki temayı kontrol et
      _checkMarkerProximity(position);
    });
  }

  void _showMarkerDialog(BuildContext context, LatLng position) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Marker"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              _addMarker(
                position,
                titleController.text,
                descriptionController.text,
              );
            },
            child: const Text("Add"),
          )
        ],
      ),
    );
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }
    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5';
    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);

    if (!mounted) return;

    setState(() {
      searchResults = data;
    });
  }

  void _moveToLocation(double lat, double lon) {
    LatLng location = LatLng(lat, lon);
    _mapController.move(location, 15.0);
    setState(() {
      _selectedPosition = location;
      searchResults = [];
      _isSearching = false;
      _searchController.clear();
    });
  }

  bool _isWithinRange(LatLng position1, LatLng position2, double range) {
    final distance = Geolocator.distanceBetween(
      position1.latitude,
      position1.longitude,
      position2.latitude,
      position2.longitude,
    );
    return distance <= range;
  }

  void _checkMarkerProximity(LatLng position) {
    if (_myLocation != null) {
      final isWithinRange =
          _isWithinRange(_myLocation!, position, 50); // 50 metre
      if (isWithinRange) {
        print('Marker ile kullanıcı konumu arasında temas var!');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _searchController.addListener(() {
      _searchPlaces(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentLocation ?? LatLng(51.5, -0.09),
              initialZoom: 13.0,
              onTap: (tapPosition, latLng) {
                _selectedPosition = latLng;
                _showMarkerDialog(context, _selectedPosition!);
              },
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
              ),
              MarkerLayer(markers: _markerks),
              if (_myLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _myLocation!,
                      width: 80,
                      height: 80,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search Places...",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: _isSearching
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _isSearching = false;
                                  searchResults = [];
                                });
                              },
                              icon: const Icon(Icons.clear),
                            )
                          : null,
                    ),
                    onTap: () {
                      setState(() {
                        _isSearching = true;
                      });
                    },
                  ),
                ),
                if (_isSearching && searchResults.isNotEmpty)
                  Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final place = searchResults[index];
                        return ListTile(
                          title: Text(place['display_name']),
                          onTap: () {
                            final lat = double.parse(place['lat']);
                            final lon = double.parse(place['lon']);
                            _moveToLocation(lat, lon);
                          },
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showMarkerInfo(MarkerModel markerModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(markerModel.title),
        content: Text(markerModel.description),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
