import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/admin_controller.dart';
import '../../../models/payment.dart';

class AdminPaymentsScreen extends ConsumerWidget {
  const AdminPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(adminPaymentsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Requests', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: paymentsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (payments) => ListView.separated(
            padding: const EdgeInsets.all(24.0),
            itemCount: payments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final Payment payment = payments[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text('Journey #${payment.journeyId}'),
                  subtitle: Text(
                    'Amount: ₦${payment.amount}\nReason: ${payment.paymentMethod}\nDate: ${payment.createdAt?.toString().split(' ').first ?? ''}\nStatus: ${payment.status}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        tooltip: 'Approve',
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Approve Payment'),
                              content: Text('Approve payment of ₦${payment.amount} for Journey #${payment.journeyId}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('Approve'),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            await ref.read(adminPaymentsControllerProvider.notifier).approvePayment(payment.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Payment approved!')),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        tooltip: 'Reject',
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Reject Payment'),
                              content: Text('Reject payment of ₦${payment.amount} for Journey #${payment.journeyId}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: const Text('Reject'),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            await ref.read(adminPaymentsControllerProvider.notifier).rejectPayment(payment.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Payment rejected!')),
                            );
                          }
                        },
                      ),
                    ],
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
