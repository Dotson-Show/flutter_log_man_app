// FILE: lib/features/driver/widgets/driver_journeys_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../widgets/empty_state.dart';
import '../../../widgets/modals/start_journey_modal.dart';
import '../../../widgets/modals/complete_journey_modal.dart';
import '../../../widgets/modals/upload_waybill_modal.dart';

class DriverJourneysTab extends ConsumerStatefulWidget {
  const DriverJourneysTab({super.key});

  @override
  ConsumerState<DriverJourneysTab> createState() => _DriverJourneysTabState();
}

class _DriverJourneysTabState extends ConsumerState<DriverJourneysTab> {
  String _selectedFilter = 'All';

  // Mock journey data
  final List<Map<String, dynamic>> journeys = [
    {
      'id': 1,
      'status': 'assigned',
      'cargo': 'Electronics Shipment',
      'from': 'Lagos',
      'to': 'Abuja',
      'distance': '780 km',
      'estimatedTime': '8 hours',
      'payment': '₦45,000',
      'customerName': 'John Doe',
      'vehicleNumber': 'LAG-123-XY',
    },
    {
      'id': 2,
      'status': 'in_transit',
      'cargo': 'Building Materials',
      'from': 'Port Harcourt',
      'to': 'Lagos',
      'distance': '450 km',
      'estimatedTime': '5 hours',
      'payment': '₦35,000',
      'customerName': 'Jane Smith',
      'vehicleNumber': 'LAG-456-AB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Journeys'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: _buildFilterChips(),
        ),
      ),
      body: journeys.isEmpty
          ? EmptyState(
        icon: Icons.route,
        title: 'No journeys yet',
        subtitle: 'You will see your assigned journeys here',
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: journeys.length,
        itemBuilder: (context, index) {
          return _buildJourneyCard(journeys[index]);
        },
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Assigned', 'In Transit', 'Completed'];

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

  Widget _buildJourneyCard(Map<String, dynamic> journey) {
    final status = journey['status'] as String;
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
                  'ID: #${journey['id']}',
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
                        journey['cargo'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Route
                _buildRouteInfo(
                  context,
                  journey['from'],
                  journey['to'],
                  journey['distance'],
                ),
                const SizedBox(height: 16),

                // Additional Info
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        Icons.access_time,
                        journey['estimatedTime'],
                        Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoChip(
                        Icons.attach_money,
                        journey['payment'],
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: _buildInfoChip(
                        Icons.person,
                        journey['customerName'],
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _buildInfoChip(
                        Icons.local_shipping,
                        journey['vehicleNumber'],
                        Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Action Buttons
                _buildActionButtons(journey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo(BuildContext context, String from, String to, String distance) {
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
              const SizedBox(height: 8),
              Text(
                distance,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
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

  Widget _buildActionButtons(Map<String, dynamic> journey) {
    final status = journey['status'] as String;

    if (status == 'assigned') {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _showJourneyDetails(journey),
              icon: const Icon(Icons.info_outline, size: 18),
              label: const Text('Details'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton.icon(
              onPressed: () => _showStartJourneyModal(journey),
              icon: const Icon(Icons.play_arrow, size: 18),
              label: const Text('Start'),
            ),
          ),
        ],
      );
    } else if (status == 'in_transit') {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showWaybillUploadModal(journey),
                  icon: const Icon(Icons.upload_file, size: 18),
                  label: const Text('Upload'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () => _showCompleteJourneyModal(journey),
                  icon: const Icon(Icons.check_circle, size: 18),
                  label: const Text('Complete'),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return FilledButton.icon(
        onPressed: () => _showJourneyDetails(journey),
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
      case 'assigned':
        return {
          'label': 'Assigned',
          'icon': Icons.assignment,
          'color': Colors.blue,
        };
      case 'in_transit':
        return {
          'label': 'In Transit',
          'icon': Icons.local_shipping,
          'color': Colors.orange,
        };
      case 'completed':
        return {
          'label': 'Completed',
          'icon': Icons.check_circle,
          'color': Colors.green,
        };
      default:
        return {
          'label': 'Unknown',
          'icon': Icons.help,
          'color': Colors.grey,
        };
    }
  }

  void _showStartJourneyModal(Map<String, dynamic> journey) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StartJourneyModal(journey: journey),
    );
  }

  void _showCompleteJourneyModal(Map<String, dynamic> journey) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CompleteJourneyModal(journey: journey),
    );
  }

  void _showWaybillUploadModal(Map<String, dynamic> journey) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const UploadWaybillModal(),
    );
  }

  void _showJourneyDetails(Map<String, dynamic> journey) {
    // Navigate to journey detail screen or show modal
  }
}