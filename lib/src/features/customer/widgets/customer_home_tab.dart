// FILE: lib/features/customer/widgets/customer_home_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../widgets/metric_card.dart';
import '../../../widgets/action_card.dart';
import '../../../widgets/user_profile_header.dart';
import '../../../widgets/modals/create_cargo_modal.dart';

class CustomerHomeTab extends ConsumerWidget {
  const CustomerHomeTab({super.key});

  void _showCreateCargoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateCargoModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          expandedHeight: 180,
          pinned: true,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Customer Hub', style: TextStyle(fontWeight: FontWeight.bold)),
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  ],
                ),
              ),
              child: userAsync.when(
                data: (user) => UserProfileHeader(
                  username: user?.username ?? "Customer",
                  subtitle: 'Active Customer',
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
                            label: 'Active Cargos',
                            value: '3',
                            icon: Icons.inventory_2,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            label: 'In Transit',
                            value: '2',
                            icon: Icons.local_shipping,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: MetricCard(
                            label: 'Completed',
                            value: '15',
                            icon: Icons.check_circle,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: MetricCard(
                            label: 'Pending Bids',
                            value: '1',
                            icon: Icons.pending_actions,
                            color: Colors.purple,
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
                  icon: Icons.add_box,
                  title: 'Create Cargo',
                  subtitle: 'Add new cargo for shipping',
                  color: Colors.blue,
                  onTap: () => _showCreateCargoModal(context),
                ),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.search,
                  title: 'Find Vehicles',
                  subtitle: 'Search and bid for available vehicles',
                  color: Colors.green,
                  onTap: () => context.push('/customer/find-vehicles'),
                ),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.inventory_2,
                  title: 'My Cargos',
                  subtitle: 'View and manage your cargos',
                  color: Colors.orange,
                  onTap: () {
                    // Switch to Cargos tab
                  },
                ),
                const SizedBox(height: 12),
                ActionCard(
                  icon: Icons.route,
                  title: 'Track Shipments',
                  subtitle: 'Monitor your active shipments',
                  color: Colors.purple,
                  onTap: () {
                    // Switch to Journeys tab
                  },
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