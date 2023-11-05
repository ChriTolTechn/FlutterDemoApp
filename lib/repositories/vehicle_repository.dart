import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/Vehicle.dart';

class VehicleRepository extends ChangeNotifier {
  Box<Vehicle>? _vehicleBox;

  Iterable<Vehicle> get vehicles =>
      _vehicleBox?.values ?? const Iterable.empty();

  Future<void> initialize(String boxName) async {
    _vehicleBox = await Hive.openBox<Vehicle>(boxName);
    log("Vehicle repo initialized");
    log("Vehicle count: ${_vehicleBox?.values.length}");
    notifyListeners();
  }

  void addVehicle(Vehicle vehicle) {
    _vehicleBox?.add(vehicle);
    vehicle.save();
    log("Added Vehicle ${vehicle.name}");
    notifyListeners();
  }

  void deleteVehicle(Vehicle vehicle) {
    vehicle.delete();
    log("Deleted Vehicle ${vehicle.name}");
    notifyListeners();
  }
}
