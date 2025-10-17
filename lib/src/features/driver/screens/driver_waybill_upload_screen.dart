import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/driver_service.dart';

class DriverWaybillUploadScreen extends ConsumerWidget {
  const DriverWaybillUploadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Placeholder for uploaded documents
    final documents = [
      {'id': 'd1', 'file': 'waybill1.pdf', 'status': 'uploaded'},
      {'id': 'd2', 'file': 'proof2.pdf', 'status': 'pending'},
    ];
    // TODO: Replace with Riverpod state and API integration

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Proof', style: TextStyle(fontWeight: FontWeight.w600)),
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
                          // Example: await ref.read(driverServiceProvider).uploadProof(journeyId: ..., filePath: ...);
                          // After upload: refresh list
                        },
                        child: const Text('Select File'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Uploaded Documents', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: documents.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.description_outlined),
                        title: Text(document['file']!),
                        subtitle: Text('Status: ${document['status']}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () {/* TODO: Download logic */},
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
