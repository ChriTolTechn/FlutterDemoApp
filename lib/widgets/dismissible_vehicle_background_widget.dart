import 'package:flutter/material.dart';

class DismissibleVehicleBackground extends StatelessWidget {
  const DismissibleVehicleBackground({super.key, required this.vehicleName});

  final String vehicleName;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Align(
        alignment: const Alignment(0.9, 0),
        child: Text("Delete '$vehicleName'"),
      ),
    );
  }
}
