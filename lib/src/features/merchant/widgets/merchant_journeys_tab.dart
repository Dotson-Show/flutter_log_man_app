// FILE: lib/features/merchant/widgets/merchant_journeys_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/modals/confirm_delivery_modal.dart';
import '../../../widgets/modals/raise_dispute_modal.dart';

class MerchantJourneysTab extends ConsumerStatefulWidget {
  const MerchantJourneysTab({super.key});

  @override
  ConsumerState<MerchantJourneysTab> createState() => _MerchantJourneysTabState();
}

class _MerchantJourneysTabState extends ConsumerState<MerchantJourneysTab> {
  String _selectedFilter = 'All';

  // Mock delivery data
  final List<Map<String, dynamic>> deliveries = [
    {
      'id': 1,
      'status': 'pending_confirmation',
      'cargo': 'Electronics Shipment',
      'from': 'Lagos',
      'to': 'Abuja',
      'expectedDate': '2025-11-05',
      'actualDate': '2025-11-05',
      'driver': 'John Driver',
      'vendor': 'ABC Logistics',
      'trackingNumber': 'TRK-2025-001',
    },
    {
      'id': 2,
      'status': 'in_transit',
      'cargo': 'Building Materials',
      'from': 'Port Harcourt',
      'to': 'Lagos',
      'expectedDate': '2025-11-06',
      'actualDate': null,
      'driver': 'Jane Driver',
      'vendor': 'Prime Movers',
      'trackingNumber': 'TRK-2025-002',
    },
    {
      'id': 3,
      'status': 'dispute',
      'cargo': 'Food Items',
      'from': 'Kano',
      'to': 'Lagos',
      'expectedDate': '2025-11-03',
      'actualDate': '2025-11-04',
      'driver': 'Mike Driver',
      'vendor': 'Swift Transport',
      'trackingNumber': 'TRK-2025-003',
      'disputeReason': 'Damaged items',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deliveries'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildFilterChips(),
        ),
      ),
      body: deliveries.isEmpty
          ? EmptyState(
        icon: Icons.local_shipping,
        title: 'No deliveries yet',
        subtitle: 'Your incoming deliveries will appear here',
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: deliveries.length,
        itemBuilder: (context, index) {
          return _buildDeliveryCard(deliveries[index]);
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'In Transit', 'Pending', 'Confirmed', 'Disputes'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: filters.map((filter) {
            final isSelected = _selectedFilter == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(filter),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _selectedFilter = filter;
                  });
                },
                selectedColor: Theme.of(context).colorScheme.primaryContainer,
                checkmarkColor: Theme.of(context).colorScheme.primary,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildDeliveryCard(Map<String, dynamic> delivery) {
    final status = delivery['status'] as String;
    final statusInfo = _getStatusInfo(status);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          // Status Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: statusInfo['color'].withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Row(
              children: [
                Icon(statusInfo['icon'], color: statusInfo['color'], size: 20),
                const SizedBox(width: 8),
                Text(
                  statusInfo['label'],
                  style: TextStyle(
                    color: statusInfo['color'],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  delivery['trackingNumber'],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cargo Info
                Row(
                  children: [
                    Icon(Icons.inventory_2, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        delivery['cargo'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Route
                _buildRouteInfo(context, delivery['from'], delivery['to']),
                const SizedBox(height: 16),

                // Info Grid
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        Icons.person,
                        delivery['driver'],
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoChip(
                        Icons.business,
                        delivery['vendor'],
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        Icons.calendar_today,
                        delivery['expectedDate'],
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoChip(
                        Icons.check_circle,
                        delivery['actualDate'] ?? 'Pending',
                        Colors.green,
                      ),
                    ),
                  ],
                ),

                // Dispute Info (if any)
                if (delivery['disputeReason'] != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.withOpacity(0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dispute Active',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                delivery['disputeReason'],
                                style: TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // Action Buttons
                _buildActionButtons(delivery),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context, String from, String to) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.location_on, color: Colors.green, size: 16),
            ),
            Container(
              width: 2,
              height: 30,
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.flag, color: Colors.red, size: 16),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                from,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                to,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Map<String, dynamic> delivery) {
    final status = delivery['status'] as String;

    if (status == 'pending_confirmation') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _showRaiseDisputeModal(delivery),
              icon: const Icon(Icons.report_problem, size: 18),
              label: const Text('Dispute'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: () => _showConfirmDeliveryModal(delivery),
              icon: const Icon(Icons.check_circle, size: 18),
              label: const Text('Confirm'),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
          ),
        ],
      );
    } else if (status == 'dispute') {
      return FilledButton.icon(
        onPressed: () => _showDisputeDetails(delivery),
        icon: const Icon(Icons.info_outline, size: 18),
        label: const Text('View Dispute'),
        style: FilledButton.styleFrom(
          backgroundColor: Colors.orange,
          minimumSize: const Size(double.infinity, 40),
        ),
      );
    } else if (status == 'in_transit') {
      return FilledButton.icon(
        onPressed: () => _showDeliveryDetails(delivery),
        icon: const Icon(Icons.local_shipping, size: 18),
        label: const Text('Track Delivery'),
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 40),
        ),
      );
    } else {
      return FilledButton.icon(
        onPressed: () => _showDeliveryDetails(delivery),
        icon: const Icon(Icons.info_outline, size: 18),
        label: const Text('View Details'),
        style: FilledButton.styleFrom(
          minimumSize: const Size(double.infinity, 40),
        ),
      );
    }
  }

  Map<String, dynamic> _getStatusInfo(String status) {
    switch (status) {
      case 'pending_confirmation':
        return {
          'label': 'Awaiting Confirmation',
          'icon': Icons.pending_actions,
          'color': Colors.orange,
        };
      case 'in_transit':
        return {
          'label': 'In Transit',
          'icon': Icons.local_shipping,
          'color': Colors.blue,
        };
      case 'confirmed':
        return {
          'label': 'Confirmed',
          'icon': Icons.check_circle,
          'color': Colors.green,
        };
      case 'dispute':
        return {
          'label': 'Dispute Active',
          'icon': Icons.report_problem,
          'color': Colors.red,
        };
      default:
        return {
          'label': 'Unknown',
          'icon': Icons.help,
          'color': Colors.grey,
        };
    }
  }

  void _showConfirmDeliveryModal(Map<String, dynamic> delivery) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ConfirmDeliveryModal(delivery: delivery),
    );
  }

  void _showRaiseDisputeModal(Map<String, dynamic> delivery) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RaiseDisputeModal(delivery: delivery),
    );
  }

  void _showDisputeDetails(Map<String, dynamic> delivery) {
    // Show dispute details
  }

  void _showDeliveryDetails(Map<String, dynamic> delivery) {
    // Show delivery details
  }
}