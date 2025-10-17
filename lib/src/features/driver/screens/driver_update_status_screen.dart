import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../controllers/driver_controller.dart';

class DriverUpdateStatusScreen extends HookConsumerWidget {
  final int journeyId;
  const DriverUpdateStatusScreen({super.key, required this.journeyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusOptions = ['started', 'in-progress', 'completed'];
    final selectedStatus = useState('in-progress');
    final proofFilePath = useState<String>('');
    final isUpdating = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Status', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Journey Status', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      ...statusOptions.map((status) => RadioListTile<String>(
                        title: Text(status),
                        value: status,
                        groupValue: selectedStatus.value,
                        onChanged: (value) => selectedStatus.value = value!,
                      )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Upload Proof', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () async {
                          // TODO: Implement file picker
                          proofFilePath.value = '/path/to/proof.pdf';
                        },
                        child: Text(proofFilePath.value.isEmpty ? 'Select Proof Document' : 'Proof: ${proofFilePath.value}'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: isUpdating.value
                    ? null
                    : () async {
                        isUpdating.value = true;
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Status Update'),
                            content: Text('Update status to ${selectedStatus.value}?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                              FilledButton(
                                onPressed: () => Navigator.of(context).pop(true),
                                child: const Text('Update'),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          try {
                            await ref.read(driverJourneysControllerProvider.notifier).updateJourneyStatus(journeyId, selectedStatus.value);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Status updated to ${selectedStatus.value}!')),
                            );
                            Navigator.of(context).pop();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error updating status: $e')),
                            );
                          } finally {
                            isUpdating.value = false;
                          }
                        } else {
                          isUpdating.value = false;
                        }
                      },
                child: isUpdating.value
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Update Status'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
