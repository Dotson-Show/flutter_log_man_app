// FILE: lib/features/driver/widgets/driver_home_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/driver_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../widgets/metric_card.dart';
import '../../../widgets/action_card.dart';
import '../../../widgets/user_profile_header.dart';

class DriverHomeTab extends ConsumerWidget {
  final Function(int)? onSwitchTab;

  const DriverHomeTab({super.key, this.onSwitchTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(driverAnalyticsControllerProvider);
    final userAsync = ref.watch(currentUserProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          expandedHeight: 180,
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Driver Hub', style: TextStyle(fontWeight: FontWeight.bold)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.tertiaryContainer,
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.3),
                  ],
                ),
              ),
              child: userAsync.when(
                data: (user) => UserProfileHeader(
                  username: user?.username ?? "Driver",
                  subtitle: 'On Duty',
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),
            ),
          ),
          actions: [
            IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: analyticsAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (e, _) => _buildErrorCard(context, e.toString(), ref),
              data: (analytics) {
                final assignedJourneys = analytics['assigned_journeys'] ?? 0;
                final completedJourneys = analytics['completed_journeys'] ?? 0;
                final pendingPayments = analytics['pending_payments'] ?? 0;
                final totalEarnings = analytics['total_earnings'] ?? 0.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStatusCard(context, assignedJourneys),
                    const SizedBox(height: 16),
                    _buildMetricsGrid(context, assignedJourneys, completedJourneys, pendingPayments, totalEarnings),
                    const SizedBox(height: 24),
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ActionCard(
                      icon: Icons.play_arrow,
                      title: 'Start Journey',
                      subtitle: 'Begin your assigned delivery',
                      color: Colors.green,
                      onTap: () => onSwitchTab?.call(1),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.location_on,
                      title: 'Update Location',
                      subtitle: 'Share your current location',
                      color: Colors.blue,
                      onTap: () => context.push('/driver/live-location'),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.check_circle,
                      title: 'Arrive at Destination',
                      subtitle: 'Mark delivery as arrived',
                      color: Colors.orange,
                      onTap: () => onSwitchTab?.call(1),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.upload_file,
                      title: 'Upload Waybill',
                      subtitle: 'Submit delivery proof',
                      color: Colors.purple,
                      onTap: () => context.push('/driver/upload-proof'),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.description,
                      title: 'View Waybills',
                      subtitle: 'Access your documents',
                      color: Colors.teal,
                      onTap: () => onSwitchTab?.call(1),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.payments,
                      title: 'Payments',
                      subtitle: 'View earnings & history',
                      color: Colors.indigo,
                      onTap: () => context.push('/driver/payments'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard(BuildContext context, int activeJourneys) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.local_shipping, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeJourneys > 0 ? 'You have active deliveries' : 'No active deliveries',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activeJourneys > 0
                        ? '$activeJourneys journeys in progress'
                        : 'Check back for new assignments',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (activeJourneys > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  activeJourneys.toString(),
                  style: TextStyle(
                    color: Colors.blue.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(
      BuildContext context,
      int assigned,
      int completed,
      int payments,
      double earnings,
      ) {
    return Row(
      children: [
        Expanded(
          child: MetricCard(
            label: 'Active',
            value: assigned.toString(),
            icon: Icons.assignment,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: MetricCard(
            label: 'Completed',
            value: completed.toString(),
            icon: Icons.check_circle,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: MetricCard(
            label: 'Earnings',
            value: '₦${earnings.toStringAsFixed(0)}',
            icon: Icons.account_balance_wallet,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }

  Widget _buildErrorCard(BuildContext context, String error, WidgetRef ref) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 8),
            Text('Error loading data', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(error, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => ref.invalidate(driverAnalyticsControllerProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}