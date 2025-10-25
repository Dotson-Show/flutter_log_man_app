// FILE: lib/features/customer/widgets/customer_journeys_tab.dart
import 'package:flutter/material.dart';
import '../../../widgets/empty_state.dart';

class CustomerJourneysTab extends StatelessWidget {
  const CustomerJourneysTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Journeys'),
        centerTitle: true,
      ),
      body: EmptyState(
        icon: Icons.route,
        title: 'No active journeys',
        subtitle: 'Your shipments will appear here',
      ),
    );
  }
}