import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/vendor_controller.dart';
import '../../../models/waybill.dart';

class VendorWaybillScreen extends ConsumerWidget {
  const VendorWaybillScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waybillsAsync = ref.watch(vendorWaybillsControllerProvider);
    final waybillsNotifier = ref.read(vendorWaybillsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Waybill', style: TextStyle(fontWeight: FontWeight.w600)),
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
                    children: [
                      const Icon(Icons.upload_file, size: 48),
                      const SizedBox(height: 16),
                      const Text('Drag and drop or select a file to upload'),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () async {
                          // TODO: Implement file picker and upload logic
                          // Example: await ref.read(vendorServiceProvider).uploadWaybill(journeyId: ..., filePath: ...);
                          // After upload:
                          await waybillsNotifier.refresh();
                        },
                        child: const Text('Select File'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Uploaded Waybills', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Expanded(
                child: waybillsAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(child: Text('Error: $e')),
                  data: (waybills) => ListView.separated(
                    itemCount: waybills.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final Waybill waybill = waybills[index];
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: const Icon(Icons.description_outlined),
                          title: Text(waybill.fileUrl ?? 'No file'),
                          subtitle: Text('Status: uploaded\nJourney: ${waybill.journeyId}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.download),
                            onPressed: () {/* TODO: Download logic */},
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
