import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VendorJourneyDetailScreen extends ConsumerWidget {
  final int journeyId;
  const VendorJourneyDetailScreen({super.key, required this.journeyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Placeholder journey details
    final journey = {
      'origin': 'Lagos',
      'destination': 'Abuja',
      'date': '2024-06-01',
      'status': 'assigned',
      'driver': 'John Doe',
      'waybill': 'waybill1.pdf',
    };
    // TODO: Replace with Riverpod state and API integration

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journey Details', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Origin: ${journey['origin']}', style: Theme.of(context).textTheme.bodyLarge),
                  Text('Destination: ${journey['destination']}', style: Theme.of(context).textTheme.bodyLarge),
                  Text('Date: ${journey['date']}', style: Theme.of(context).textTheme.bodyLarge),
                  Text('Status: ${journey['status']}', style: Theme.of(context).textTheme.bodyLarge),
                  Text('Driver: ${journey['driver']}', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 16),
                  if (journey['waybill'] != null)
                    Row(
                      children: [
                        const Icon(Icons.description_outlined),
                        const SizedBox(width: 8),
                        Text('Waybill: ${journey['waybill']}'),
                        IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {/* TODO: Download waybill */},
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: () {/* TODO: Update status logic */},
                    child: const Text('Update Status'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
