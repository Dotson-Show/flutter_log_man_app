import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/driver_controller.dart';
import '../../../models/journey.dart';

class DriverJourneyDetailScreen extends ConsumerWidget {
  final int journeyId;
  const DriverJourneyDetailScreen({super.key, required this.journeyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeysAsync = ref.watch(driverJourneysControllerProvider);
    
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
        child: journeysAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (journeys) {
            final journey = journeys.firstWhere((j) => j.id == journeyId);
            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Origin: ${journey.origin}', style: Theme.of(context).textTheme.bodyLarge),
                      Text('Destination: ${journey.destination}', style: Theme.of(context).textTheme.bodyLarge),
                      Text('Date: ${journey.scheduledAt?.toString().split(' ').first ?? ''}', style: Theme.of(context).textTheme.bodyLarge),
                      Text('Status: ${journey.status}', style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 16),
                      // TODO: Add waybill info if available
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () => Navigator.pushNamed(context, '/driver/update-status', arguments: journeyId),
                        child: const Text('Update Status'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
