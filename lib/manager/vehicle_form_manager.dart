import 'package:cross_flutter_application/helper/coordinate_helper.dart';
import 'package:cross_flutter_application/models/Vehicle.dart';
import 'package:uuid/uuid.dart';

class VehicleFormManager {
  String _name = "";
  num? _latitude;
  num? _longitude;
  VehicleType? _vehicleType;

  set setName(String name) => _name = name;
  set setLatitude(String latitude) => _latitude = num.tryParse(latitude);
  set setLongitude(String longitude) => _longitude = num.tryParse(longitude);
  set setVehicleType(VehicleType? vehicleType) => _vehicleType = vehicleType;

  void checkValid() {
    List<String> invalidFields = [];

    if (_name.isEmpty) invalidFields.add("name");
    if (CoordinateHelper.isValidLatitude(_latitude) == false) {
      invalidFields.add("latitude");
    }
    if (CoordinateHelper.isValidLongitude(_longitude) == false) {
      invalidFields.add("longitude");
    }
    if (_vehicleType == null) invalidFields.add("vehicle-type");

    if (invalidFields.isNotEmpty) {
      String errorMessage = "Invalid parameters: ${invalidFields.join(", ")}";
      throw FormatException(errorMessage);
    }
  }

  Vehicle convertToVehicle() {
    // Throws exception if invalid
    checkValid();

    Vehicle newVehicle = Vehicle(
        const Uuid().v1(), _name, _longitude!, _latitude!, _vehicleType!);
    _resetInformation();
    return newVehicle;
  }

  void _resetInformation() {
    _name = "";
    _latitude = null;
    _longitude = null;
    _vehicleType = VehicleType.car;
  }
}
