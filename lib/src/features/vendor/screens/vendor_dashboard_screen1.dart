import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/vendor_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../widgets/logout_button.dart';

class VendorDashboardScreen extends ConsumerWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsync = ref.watch(vendorAnalyticsControllerProvider);
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            expandedHeight: 160,
            pinned: true,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
                  data: (user) => Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 60),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.store, size: 20),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            user?.username ?? "Vendor",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {}),
              const LogoutButton(),
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
                      _buildActionCard(
                        context,
                        icon: Icons.pending_actions,
                        title: 'Manage Requests',
                        subtitle: '$pendingRequests pending requests',
                        color: Colors.orange,
                        onTap: () => context.push('/vendor/requests'),
                      ),
                      const SizedBox(height: 12),
                      _buildActionCard(
                        context,
                        icon: Icons.local_shipping,
                        title: 'Assign Drivers',
                        subtitle: 'Manage journey assignments',
                        color: Colors.blue,
                        onTap: () => context.push('/vendor/requests'),
                      ),
                      const SizedBox(height: 12),
                      _buildActionCard(
                        context,
                        icon: Icons.description,
                        title: 'Upload Waybill',
                        subtitle: 'Document management',
                        color: Colors.green,
                        onTap: () => context.push('/vendor/waybill'),
                      ),
                      const SizedBox(height: 12),
                      _buildActionCard(
                        context,
                        icon: Icons.analytics,
                        title: 'View Analytics',
                        subtitle: 'Performance insights',
                        color: Colors.purple,
                        onTap: () => context.push('/vendor/analytics'),
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
      ),
    );
  }

  Widget _buildMetricsGrid(BuildContext context, int pending, int completed, int payments, double revenue) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                label: 'Pending',
                value: pending.toString(),
                icon: Icons.pending_actions,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
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
              child: _MetricCard(
                label: 'Payments',
                value: payments.toString(),
                icon: Icons.payments,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
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

  Widget _buildActionCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Theme.of(context).colorScheme.outline.withOpacity(0.2)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).colorScheme.outline),
            ],
          ),
        ),
      ),
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

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: color.withOpacity(0.3)),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ],
        ),
      ),
    );
  }
}