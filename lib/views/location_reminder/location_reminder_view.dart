import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../blocs/location_bloc/location_bloc.dart';
import '../../blocs/location_bloc/location_event.dart';
import '../../blocs/location_bloc/location_state.dart';

import '../../core/widget/user/profile_image.dart';

class LocationReminderView extends StatefulWidget {
  const LocationReminderView({super.key});

  @override
  _LocationReminderViewState createState() => _LocationReminderViewState();
}

class _LocationReminderViewState extends State<LocationReminderView> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Uygulama başlatıldığında mevcut konumu alır ve izlemeye başlar
    context.read<LocationBloc>().add(GetCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: context.read<LocationBloc>(),
        child: Stack(
          children: [
            BlocBuilder<LocationBloc, LocationState>(
              builder: (context, state) {
                if (state.currentPosition == null) {
                  return const Center(child: CircularProgressIndicator());
                }

                return FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: state.currentPosition!,
                    initialZoom: 17.0,
                    onPositionChanged: (position, hasGesture) {
                      if (hasGesture) {
                        // Harita kullanıcı tarafından hareket ettirildiyse merkez güncellenebilir.
                      }
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          "https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png",
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: state.currentPosition!,
                          child: const ViProfileImage(size: 30),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
