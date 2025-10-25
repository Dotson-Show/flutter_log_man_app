// FILE: lib/features/vendor/widgets/vendor_journeys_tab.dart
import 'package:flutter/material.dart';

class VendorJourneysTab extends StatelessWidget {
  const VendorJourneysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journeys'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.route, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text('Journeys Tab', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Journey tracking coming soon', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}