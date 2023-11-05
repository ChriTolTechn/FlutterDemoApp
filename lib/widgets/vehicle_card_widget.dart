import 'package:flutter/material.dart';

import '../helper/vehicle_helper.dart';
import '../models/Vehicle.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.vehicle});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(VehicleHelper.getVehicleTypeIcon(vehicle.vehicleType)),
        title: Text(vehicle.name),
        subtitle: Text("Lat: ${vehicle.latitude} - Long: ${vehicle.longitude}"),
      ),
    );
  }
}
