import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/driver_controller.dart';
import '../../../models/journey.dart';

class DriverJourneysScreen extends ConsumerWidget {
  const DriverJourneysScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeysAsync = ref.watch(driverJourneysControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Journeys', style: TextStyle(fontWeight: FontWeight.w600)),
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
          data: (journeys) => ListView.separated(
            padding: const EdgeInsets.all(24.0),
            itemCount: journeys.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final Journey journey = journeys[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text('${journey.origin} → ${journey.destination}'),
                  subtitle: Text('Date: ${journey.scheduledAt?.toString().split(' ').first ?? ''}\nStatus: ${journey.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (journey.status == 'assigned') ...[
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          tooltip: 'Accept',
                          onPressed: () async {
                            await ref.read(driverJourneysControllerProvider.notifier).acceptJourney(journey.id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          tooltip: 'Decline',
                          onPressed: () async {
                            await ref.read(driverJourneysControllerProvider.notifier).declineJourney(journey.id);
                          },
                        ),
                      ],
                      if (journey.status == 'in-progress')
                        IconButton(
                          icon: const Icon(Icons.update, color: Colors.blue),
                          tooltip: 'Update Status',
                          onPressed: () => Navigator.pushNamed(context, '/driver/update-status', arguments: journey.id),
                        ),
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, '/driver/journey-detail', arguments: journey.id),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
