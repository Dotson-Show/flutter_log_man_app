// FILE: lib/features/customer/widgets/customer_cargos_tab.dart
import 'package:flutter/material.dart';
import '../../../widgets/empty_state.dart';

class CustomerCargosTab extends StatelessWidget {
  const CustomerCargosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cargos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Show create cargo modal
            },
          ),
        ],
      ),
      body: EmptyState(
        icon: Icons.inventory_2,
        title: 'No cargos yet',
        subtitle: 'Create your first cargo to get started',
        action: FilledButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add),
          label: const Text('Create Cargo'),
        ),
      ),
    );
  }
}