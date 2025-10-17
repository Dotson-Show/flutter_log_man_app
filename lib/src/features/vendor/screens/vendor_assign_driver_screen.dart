import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/vendor_controller.dart';
import '../../../models/user.dart';

class VendorAssignDriverScreen extends ConsumerWidget {
  final int journeyId;
  const VendorAssignDriverScreen({super.key, required this.journeyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final driversAsync = ref.watch(vendorDriversControllerProvider);
    final requestsNotifier = ref.read(vendorRequestsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assign Driver', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: driversAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (drivers) => ListView.separated(
            padding: const EdgeInsets.all(24.0),
            itemCount: drivers.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final User driver = drivers[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text(driver.username),
                  trailing: FilledButton(
                    onPressed: () async {
                      final assigned = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Confirm Assignment'),
                          content: Text('Assign ${driver.username} to this journey?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Assign'),
                            ),
                          ],
                        ),
                      );
                      if (assigned == true) {
                        await requestsNotifier.assignDriver(journeyId, driver.id);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Driver ${driver.username} assigned!')),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Assign'),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
