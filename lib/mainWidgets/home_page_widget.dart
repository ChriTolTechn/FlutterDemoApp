import 'dart:async';
import 'dart:developer';

import 'package:cross_flutter_application/helper/toast_helper.dart';
import 'package:cross_flutter_application/models/Vehicle.dart';
import 'package:cross_flutter_application/riverpod_providers.dart';
import 'package:cross_flutter_application/widgets/vehicle_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../widgets/dismissible_vehicle_background_widget.dart';
import '../widgets/vehicle_card_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicleRepository = ref.watch(vehicleRepositoryNotifierProvider);

    void onAddVehicle() async {
      var newVehicle = await settingModalBottomSheet(context);
      if (newVehicle != null) {
        try {
          vehicleRepository.addVehicle(newVehicle);
          if (context.mounted) {
            ToastHelper.showSuccessToast(
                context, "Successfully saved vehicle: ${newVehicle.name}");
          }
        } catch (ex) {
          if (context.mounted) {
            ToastHelper.showErrorToast(
                context, "Error saving Vehicle to the db");
            log(ex.toString());
          }
        }
      }
    }

    void onDeleteVehicle(Vehicle vehicle) {
      vehicleRepository.deleteVehicle(vehicle);
      ToastHelper.showSuccessToast(
          context, "Successfully deleted vehicle '${vehicle.name}'");
    }

    Future<bool> confirmDialog(String vehicleName) {
      Completer<bool> completer = Completer<bool>();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete Confirmation'),
              content: Text(
                  'Are you sure you want to delete $vehicleName? This action cannot be undone.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(false);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    completer.complete(true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
          barrierDismissible: false);

      return completer.future;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Vehicles",
            style:
                TextStyle(color: Theme.of(context).colorScheme.onBackground)),
      ),
      body: vehicleRepository.vehicles.isNotEmpty
          ? ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              children: vehicleRepository.vehicles.map((vehicle) {
                return Dismissible(
                    key: Key(const Uuid().v1()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) => onDeleteVehicle(vehicle),
                    dismissThresholds: const {DismissDirection.endToStart: 0.5},
                    confirmDismiss: (_) async {
                      return await confirmDialog(vehicle.name);
                    },
                    background:
                        DismissibleVehicleBackground(vehicleName: vehicle.name),
                    child: VehicleCard(vehicle: vehicle));
              }).toList())
          : const Center(
              child: Text("No vehicles. Tap the '+' button to add one!"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAddVehicle,
        heroTag: "addVehicle_fab",
        tooltip: "Add vehicle",
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<Vehicle?> settingModalBottomSheet(context) async {
    final res = await showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return const VehicleFormWidget();
        });

    return res != null ? res[0] as Vehicle : null;
  }
}
