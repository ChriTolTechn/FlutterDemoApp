import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapControllerService extends ChangeNotifier {
  bool _doUpdatePosition = true;
  bool get doUpdatePosition => _doUpdatePosition;

  GoogleMapController? _controller;

  void updatePosition(CameraPosition newPosition) {
    if (_doUpdatePosition) {
      _controller?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
    }
  }

  void setController(GoogleMapController controller) {
    _controller = controller;
  }

  void changeDoUpdatePosition() {
    _doUpdatePosition = !_doUpdatePosition;
    notifyListeners();

    if (_doUpdatePosition) {
      Geolocator.checkPermission().then((value) {
        if (value == LocationPermission.whileInUse) {
          Geolocator.getCurrentPosition().then((location) => updatePosition(
                CameraPosition(
                    target: LatLng(location.latitude, location.longitude),
                    zoom: 15),
              ));
        }
      });
    }
  }
}
