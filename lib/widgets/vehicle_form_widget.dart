import 'package:cross_flutter_application/helper/toast_helper.dart';
import 'package:cross_flutter_application/riverpod_providers.dart';
import 'package:cross_flutter_application/validators/data_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../inputFormatters/DecimalTextInputFormatter.dart';
import '../models/Vehicle.dart';

class VehicleFormWidget extends ConsumerWidget {
  const VehicleFormWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formManager = ref.watch(vehicleFormManagerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Add vehicle", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(children: [
                TextFormField(
                  onChanged: (String newValue) =>
                      formManager.setName = newValue,
                  validator: (String? value) =>
                      DataValidators.isValidName(value)
                          ? null
                          : "Name must be at least one character",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Name your vehicle",
                      labelText: "Vehicle Name *"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  onChanged: (String newValue) =>
                      formManager.setLatitude = newValue,
                  validator: (String? value) =>
                      DataValidators.isValidLatitudeInput(value)
                          ? null
                          : "Latitude has to be in range of -90.0 to 90.0",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [DecimalTextInputFormatter()],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "e.g. 48.2082",
                      labelText: "Latitude *"),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  onChanged: (String newValue) =>
                      formManager.setLongitude = newValue,
                  validator: (String? value) =>
                      DataValidators.isValidLongitudeInput(value)
                          ? null
                          : "Longitude has to be in range of -180.0 to 180.0",
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [DecimalTextInputFormatter()],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "e.g. 16.3738",
                      labelText: "Longitude *"),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  validator: (VehicleType? value) =>
                      value == null ? "Type must be selected" : null,
                  items: VehicleType.values
                      .map<DropdownMenuItem<VehicleType>>((vehicleType) {
                    return DropdownMenuItem(
                        value: vehicleType, child: Text(vehicleType.name));
                  }).toList(),
                  onChanged: (VehicleType? value) =>
                      formManager.setVehicleType = value,
                ),
              ]),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  var newVehicle = formManager.convertToVehicle();
                  Navigator.of(context).pop([newVehicle]);
                } on FormatException catch (ex) {
                  ToastHelper.showErrorToast(context, ex.message);
                }
              },
              child: const Text('Add'),
            )
          ],
        ),
      ),
    );
  }
}
