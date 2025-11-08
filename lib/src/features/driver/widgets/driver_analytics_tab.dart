// FILE: lib/features/driver/widgets/driver_analytics_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/driver_controller.dart';
import '../../../widgets/metric_card.dart';

class DriverAnalyticsTab extends ConsumerWidget {
  const DriverAnalyticsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(driverAnalyticsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        centerTitle: true,
      ),
      body: analyticsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text('Error loading analytics', style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        data: (analytics) {
          final assignedJourneys = analytics['assigned_journeys'] ?? 0;
          final completedJourneys = analytics['completed_journeys'] ?? 0;
          final pendingPayments = analytics['pending_payments'] ?? 0;
          final totalEarnings = analytics['total_earnings'] ?? 0.0;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Performance Overview',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      label: 'Active',
                      value: assignedJourneys.toString(),
                      icon: Icons.assignment,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      label: 'Completed',
                      value: completedJourneys.toString(),
                      icon: Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: MetricCard(
                      label: 'Pending Pay',
                      value: pendingPayments.toString(),
                      icon: Icons.pending,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: MetricCard(
                      label: 'Total Earnings',
                      value: '₦${totalEarnings.toStringAsFixed(0)}',
                      icon: Icons.account_balance_wallet,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'This Month',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _buildStatRow(context, 'Deliveries', '12'),
                      const Divider(height: 24),
                      _buildStatRow(context, 'Distance Covered', '4,560 km'),
                      const Divider(height: 24),
                      _buildStatRow(context, 'Average Rating', '4.8 ⭐'),
                      const Divider(height: 24),
                      _buildStatRow(context, 'On-Time Delivery', '95%'),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}