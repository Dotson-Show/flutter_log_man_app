// FILE: lib/features/vendor/widgets/vendor_vehicles_tab.dart
import 'package:flutter/material.dart';

class VendorVehiclesTab extends StatelessWidget {
  const VendorVehiclesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicles'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.local_shipping, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text('Vehicles Tab', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Vehicle management coming soon', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}