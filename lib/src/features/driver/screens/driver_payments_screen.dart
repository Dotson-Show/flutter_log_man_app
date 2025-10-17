import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/driver_controller.dart';
import '../../../models/payment.dart';

class DriverPaymentsScreen extends ConsumerWidget {
  const DriverPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(driverPaymentsControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments', style: TextStyle(fontWeight: FontWeight.w600)),
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
                  subtitle: Text('Date: ${payment.createdAt?.toString().split(' ').first ?? ''}\nAmount: ₦${payment.amount}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        payment.status,
                        style: TextStyle(
                          color: payment.status == 'confirmed' ? Colors.green : Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (payment.status == 'pending')
                        TextButton(
                          onPressed: () async {
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirm Payment'),
                                content: Text('Confirm payment of ₦${payment.amount} for Journey #${payment.journeyId}?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                  ),
                                  FilledButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Confirm'),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed == true) {
                              await ref.read(driverPaymentsControllerProvider.notifier).confirmPayment(payment.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Payment confirmed!')),
                              );
                            }
                          },
                          child: const Text('Confirm'),
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
