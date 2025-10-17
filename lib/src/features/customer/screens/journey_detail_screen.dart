// lib/src/features/customer/screens/journey_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../controllers/journey_controller.dart';
import '../../../models/waybill.dart';
import '../../../models/journey.dart';
import 'package:file_picker/file_picker.dart';

part 'journey_detail_screen.g.dart';

// Provider for waybills data
@riverpod
class WaybillList extends _$WaybillList {
  @override
  FutureOr<List<Waybill>> build(int journeyId) async {
    final controller = ref.read(journeyControllerProvider.notifier);
    return controller.fetchWaybills(journeyId);
  }

  Future<void> refresh(int journeyId) async {
    state = const AsyncLoading();
    try {
      final controller = ref.read(journeyControllerProvider.notifier);
      final waybills = await controller.fetchWaybills(journeyId);
      state = AsyncData(waybills);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// Provider for journey details
@riverpod
class JourneyDetail extends _$JourneyDetail {
  @override
  FutureOr<Journey> build(int journeyId) async {
    final controller = ref.read(journeyControllerProvider.notifier);
    return controller.fetchJourneyDetail(journeyId);
  }
}

// Upload state provider
@riverpod
class UploadState extends _$UploadState {
  @override
  bool build() => false;

  void setUploading(bool uploading) {
    state = uploading;
  }
}

class JourneyDetailScreen extends HookConsumerWidget {
  final int journeyId;
  const JourneyDetailScreen({super.key, required this.journeyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeyDetailState = ref.watch(journeyDetailProvider(journeyId));
    final waybillState = ref.watch(waybillListProvider(journeyId));
    final downloadProgress = ref.watch(downloadProgressProvider);
    final cancelToken = ref.watch(downloadCancelTokenProvider);
    final isUploading = ref.watch(uploadStateProvider);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text("Journey Details"),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref.invalidate(journeyDetailProvider(journeyId));
                  ref.read(waybillListProvider(journeyId).notifier).refresh(journeyId);
                },
                tooltip: 'Refresh',
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Journey Details Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: journeyDetailState.when(
                      data: (journey) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.info, color: Colors.blue),
                              const SizedBox(width: 8),
                              Text(
                                'Journey #${journey.id}',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildDetailRow('Origin', journey.origin, Icons.location_on),
                          const SizedBox(height: 8),
                          _buildDetailRow('Destination', journey.destination, Icons.location_off),
                          const SizedBox(height: 8),
                          _buildDetailRow('Status', journey.status.toUpperCase(), Icons.info_outline),
                          if (journey.transportType != null) ...[
                            const SizedBox(height: 8),
                            _buildDetailRow('Transport', journey.transportType!.toUpperCase(), Icons.local_shipping),
                          ],
                          if (journey.scheduledAt != null) ...[
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              'Scheduled',
                              _formatDateTime(journey.scheduledAt!),
                              Icons.schedule,
                            ),
                          ],
                          if (journey.createdAt != null) ...[
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              'Created',
                              _formatDateTime(journey.createdAt!),
                              Icons.calendar_today,
                            ),
                          ],
                        ],
                      ),
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (error, stackTrace) => Column(
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: Colors.red),
                          const SizedBox(height: 8),
                          Text('Error loading journey details: $error'),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () => ref.invalidate(journeyDetailProvider(journeyId)),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Waybills Section
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.description, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              'Waybills',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Spacer(),
                            ElevatedButton.icon(
                              onPressed: isUploading ? null : () => _uploadWaybill(context, ref),
                              icon: isUploading
                                  ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                                  : const Icon(Icons.upload_file),
                              label: Text(isUploading ? 'Uploading...' : 'Upload'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        waybillState.when(
                          data: (waybills) {
                            if (waybills.isEmpty) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      Icon(Icons.description_outlined, size: 48, color: Colors.grey),
                                      SizedBox(height: 8),
                                      Text(
                                        'No waybills found',
                                        style: TextStyle(color: Colors.grey, fontSize: 16),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'Upload the first waybill for this journey',
                                        style: TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: waybills.length,
                              separatorBuilder: (context, index) => const Divider(),
                              itemBuilder: (context, index) {
                                final waybill = waybills[index];
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: const CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(Icons.description, color: Colors.white),
                                  ),
                                  title: Text(
                                    waybill.waybillNumber ?? 'Waybill #${index + 1}',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (waybill.createdAt != null)
                                        Text(
                                          'Uploaded: ${_formatDateTime(waybill.createdAt!)}',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      if (waybill.fileUrl != null && waybill.fileUrl!.isNotEmpty)
                                        Text(
                                          'File available for download',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                    ],
                                  ),
                                  trailing: waybill.fileUrl != null && waybill.fileUrl!.isNotEmpty
                                      ? IconButton(
                                    icon: const Icon(Icons.download),
                                    onPressed: downloadProgress != null
                                        ? null
                                        : () => _downloadWaybill(context, ref, waybill.fileUrl!),
                                    tooltip: 'Download waybill',
                                  )
                                      : const Icon(Icons.cloud_off, color: Colors.grey),
                                );
                              },
                            );
                          },
                          loading: () => const Center(
                            child: Padding(
                              padding: EdgeInsets.all(32.0),
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          error: (error, stackTrace) => Column(
                            children: [
                              const Icon(Icons.error_outline, size: 48, color: Colors.red),
                              const SizedBox(height: 8),
                              Text('Error loading waybills: $error'),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => ref
                                    .read(waybillListProvider(journeyId).notifier)
                                    .refresh(journeyId),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Download Progress Overlay
        AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: downloadProgress != null ? Offset.zero : const Offset(0, 1),
          curve: Curves.easeInOut,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: downloadProgress != null ? 1.0 : 0.0,
            child: Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Material(
                elevation: 8,
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  padding: const EdgeInsets.all(16),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        const Icon(Icons.download),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Downloading waybill...',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              const SizedBox(height: 4),
                              LinearProgressIndicator(value: downloadProgress),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          downloadProgress != null
                              ? "${(downloadProgress * 100).toStringAsFixed(0)}%"
                              : "",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(width: 12),
                        if (downloadProgress != null && cancelToken != null)
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              ref.read(journeyControllerProvider.notifier).cancelDownload();
                            },
                            tooltip: 'Cancel download',
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  }

  Future<void> _uploadWaybill(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        ref.read(uploadStateProvider.notifier).setUploading(true);

        await ref
            .read(journeyControllerProvider.notifier)
            .uploadWaybill(journeyId, result.files.single.path!);

        // Refresh waybills after successful upload
        await ref.read(waybillListProvider(journeyId).notifier).refresh(journeyId);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Waybill uploaded successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Upload failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      ref.read(uploadStateProvider.notifier).setUploading(false);
    }
  }

  Future<void> _downloadWaybill(BuildContext context, WidgetRef ref, String fileUrl) async {
    try {
      await ref
          .read(journeyControllerProvider.notifier)
          .downloadAndOpenWaybillWithProgress(fileUrl);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Waybill downloaded and opened successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}