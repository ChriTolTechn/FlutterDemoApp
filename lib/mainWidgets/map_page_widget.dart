import 'dart:async';
import 'dart:developer';

import 'package:cross_flutter_application/riverpod_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationStreamProvider);
    final cameraPosition = ref.watch(mapControllerServiceNotifierProvider);
    final vehicleProvider = ref.watch(vehicleRepositoryNotifierProvider);
    final bitmapProvider = ref.watch(markerIconServiceProvider);

    requestPermission().whenComplete(() => null);

    Future(() {
      final latestLocation = location.value;
      if (latestLocation != null) {
        cameraPosition.updatePosition(CameraPosition(
          target: LatLng(latestLocation.latitude, latestLocation.longitude),
          zoom: 15,
        ));
      }
    });

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 15,
        ),
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          cameraPosition.setController(controller);
        },
        markers: Set<Marker>.of(vehicleProvider.vehicles.map<Marker>((vehicle) {
          return Marker(
              markerId: MarkerId(const Uuid().v1()),
              icon: bitmapProvider.getVehicleTypeBitmap(vehicle.vehicleType),
              infoWindow: InfoWindow(
                  title: vehicle.name, snippet: vehicle.vehicleType.name),
              position: LatLng(
                  vehicle.latitude.toDouble(), vehicle.longitude.toDouble()));
        })),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "location_fab",
        tooltip: cameraPosition.doUpdatePosition
            ? "Disable following position"
            : "Enable following position",
        onPressed: cameraPosition.changeDoUpdatePosition,
        child: Icon(cameraPosition.doUpdatePosition
            ? Icons.my_location
            : Icons.location_disabled),
      ),
    );
  }

  Future<bool> requestPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      log("Location Services Disabled");
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    return permission == LocationPermission.whileInUse;
  }
}
