// FILE: lib/features/vendor/widgets/vendor_home_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/vendor_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../widgets/metric_card.dart';
import '../../../widgets/action_card.dart';
import '../../../widgets/user_profile_header.dart';
import '../../../widgets/modals/add_vehicle_modal.dart';
import '../../../widgets/modals/upload_waybill_modal.dart';

class VendorHomeTab extends ConsumerWidget {
  const VendorHomeTab({super.key});

  void _showAddVehicleModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddVehicleModal(),
    );
  }

  void _showUploadWaybillModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const UploadWaybillModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(vendorAnalyticsControllerProvider);
    final userAsync = ref.watch(currentUserProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          expandedHeight: 180,
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Vendor Hub', style: TextStyle(fontWeight: FontWeight.bold)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.secondaryContainer,
                    Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                  ],
                ),
              ),
              child: userAsync.when(
                data: (user) => UserProfileHeader(
                  username: user?.username ?? "Vendor",
                  subtitle: 'Verified Vendor',
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
                final pendingRequests = analytics['pending_requests'] ?? 0;
                final completedJourneys = analytics['completed_journeys'] ?? 0;
                final pendingPayments = analytics['pending_payments'] ?? 0;
                final totalRevenue = analytics['total_revenue'] ?? 0.0;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildMetricsGrid(context, pendingRequests, completedJourneys, pendingPayments, totalRevenue),
                    const SizedBox(height: 24),
                    Text('Quick Actions', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ActionCard(
                      icon: Icons.add_circle,
                      title: 'Add Vehicle',
                      subtitle: 'Register a new vehicle',
                      color: Colors.teal,
                      onTap: () => _showAddVehicleModal(context),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.pending_actions,
                      title: 'Manage Requests',
                      subtitle: '$pendingRequests pending requests',
                      color: Colors.orange,
                      onTap: () => context.push('/vendor/requests'),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.local_shipping,
                      title: 'Assign Drivers',
                      subtitle: 'Manage journey assignments',
                      color: Colors.blue,
                      onTap: () => context.push('/vendor/requests'),
                    ),
                    const SizedBox(height: 12),
                    ActionCard(
                      icon: Icons.description,
                      title: 'Upload Waybill',
                      subtitle: 'Document management',
                      color: Colors.green,
                      onTap: () => _showUploadWaybillModal(context),
                    ),
                    const SizedBox(height: 24),
                    _buildRecentActivity(context),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid(BuildContext context, int pending, int completed, int payments, double revenue) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: 'Pending',
                value: pending.toString(),
                icon: Icons.pending_actions,
                color: Colors.orange,
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
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricCard(
                label: 'Payments',
                value: payments.toString(),
                icon: Icons.payments,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricCard(
                label: 'Revenue',
                value: '₦${revenue.toStringAsFixed(0)}',
                icon: Icons.attach_money,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.history, size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5)),
                  const SizedBox(height: 8),
                  Text('No recent activity', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
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
              onPressed: () => ref.invalidate(vendorAnalyticsControllerProvider),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}