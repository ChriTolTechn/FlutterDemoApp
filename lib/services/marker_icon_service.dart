import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/Vehicle.dart';

class MarkerIconService {
  bool _initialized = false;

  late BitmapDescriptor _carBitmap;
  late BitmapDescriptor _bikeBitmap;
  late BitmapDescriptor _truckBitmap;
  late BitmapDescriptor _helicopterBitmap;
  late BitmapDescriptor _planeBitmap;

  Future<void> initialize() async {
    if (_initialized) return;

    Future<BitmapDescriptor> loadImage(String assetPath) async {
      return BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        assetPath,
      );
    }

    var isIOS = Platform.isIOS;
    var rootPath = 'assets/markers/${isIOS ? "ios" : "android"}/';

    final futures = <Future<BitmapDescriptor>>[];
    futures.add(loadImage('${rootPath}sedan.png'));
    futures.add(loadImage('${rootPath}motorbike.png'));
    futures.add(loadImage('${rootPath}truck.png'));
    futures.add(loadImage('${rootPath}helicopter.png'));
    futures.add(loadImage('${rootPath}plane.png'));

    final bitmaps = await Future.wait(futures);

    _carBitmap = bitmaps[0];
    _bikeBitmap = bitmaps[1];
    _truckBitmap = bitmaps[2];
    _helicopterBitmap = bitmaps[3];
    _planeBitmap = bitmaps[4];

    log("Bitmapdescriptors initalized");
    _initialized = true;
  }

  BitmapDescriptor getVehicleTypeBitmap(VehicleType type) {
    switch (type) {
      case VehicleType.car:
        return _carBitmap;
      case VehicleType.bike:
        return _bikeBitmap;
      case VehicleType.truck:
        return _truckBitmap;
      case VehicleType.helicopter:
        return _helicopterBitmap;
      case VehicleType.plane:
        return _planeBitmap;
    }
  }
}
