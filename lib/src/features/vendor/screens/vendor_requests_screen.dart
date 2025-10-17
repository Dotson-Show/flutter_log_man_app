import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/vendor_controller.dart';
import '../../../models/journey.dart';

class VendorRequestsScreen extends ConsumerWidget {
  const VendorRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(vendorRequestsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Requests', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: requestsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (requests) => ListView.separated(
            padding: const EdgeInsets.all(24.0),
            itemCount: requests.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final Journey req = requests[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text('${req.origin} → ${req.destination}'),
                  subtitle: Text('Date: ${req.scheduledAt?.toString().split(' ').first ?? ''}\nStatus: ${req.status}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (req.status == 'new') ...[
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          tooltip: 'Accept',
                          onPressed: () async {
                            await ref.read(vendorRequestsControllerProvider.notifier).acceptRequest(req.id);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          tooltip: 'Reject',
                          onPressed: () async {
                            await ref.read(vendorRequestsControllerProvider.notifier).rejectRequest(req.id);
                          },
                        ),
                      ],
                      if (req.status == 'assigned')
                        IconButton(
                          icon: const Icon(Icons.person_add, color: Colors.blue),
                          tooltip: 'Assign Driver',
                          onPressed: () => Navigator.pushNamed(context, '/vendor/assign-driver', arguments: req.id),
                        ),
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, '/vendor/journey-detail', arguments: req.id),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
