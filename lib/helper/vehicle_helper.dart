import 'package:flutter/widgets.dart' show IconData;

import '../customIcons/custom_icons_icons.dart';
import '../models/Vehicle.dart';

class VehicleHelper {
  static IconData getVehicleTypeIcon(VehicleType type) {
    switch (type) {
      case VehicleType.car:
        return CustomIcons.car_side;
      case VehicleType.bike:
        return CustomIcons.motorcycle;
      case VehicleType.truck:
        return CustomIcons.truck;
      case VehicleType.helicopter:
        return CustomIcons.helicopter;
      case VehicleType.plane:
        return CustomIcons.plane;
    }
  }
}
