// FILE: lib/features/vendor/widgets/vendor_analytics_tab.dart
import 'package:flutter/material.dart';

class VendorAnalyticsTab extends StatelessWidget {
  const VendorAnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text('Analytics Tab', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Detailed analytics coming soon', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}