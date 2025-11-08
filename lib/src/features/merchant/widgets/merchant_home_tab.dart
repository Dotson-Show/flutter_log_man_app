// FILE: lib/features/merchant/widgets/merchant_home_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../widgets/metric_card.dart';
import '../../../widgets/action_card.dart';
import '../../../widgets/user_profile_header.dart';

class MerchantHomeTab extends ConsumerWidget {
  final Function(int)? onSwitchTab;

  const MerchantHomeTab({super.key, this.onSwitchTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          expandedHeight: 180,
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Merchant Hub', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  username: user?.username ?? "Merchant",
                  subtitle: 'Verified Merchant',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Metrics Grid
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: MetricCard(
                            label: 'Pending',
                            value: '3',
                            icon: Icons.pending_actions,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            label: 'In Transit',
                            value: '2',
                            icon: Icons.local_shipping,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: MetricCard(
                            label: 'Received',
                            value: '15',
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            label: 'Disputes',
                            value: '1',
                            icon: Icons.report_problem,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Quick Actions',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ActionCard(
                  icon: Icons.local_shipping,
                  title: 'Pending Deliveries',
                  subtitle: 'Confirm received shipments',
                  color: Colors.orange,
                  onTap: () => onSwitchTab?.call(1),
                ),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.fact_check,
                  title: 'Inspect Goods',
                  subtitle: 'Verify delivered items',
                  color: Colors.blue,
                  onTap: () => onSwitchTab?.call(1),
                ),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.report_problem,
                  title: 'Raise Dispute',
                  subtitle: 'Report delivery issues',
                  color: Colors.red,
                  onTap: () => onSwitchTab?.call(1),
                ),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.history,
                  title: 'Delivery History',
                  subtitle: 'View past deliveries',
                  color: Colors.purple,
                  onTap: () => onSwitchTab?.call(1),
                ),
                const SizedBox(height: 24),
                _buildRecentActivity(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
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
                  Icon(
                    Icons.history,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No recent activity',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}