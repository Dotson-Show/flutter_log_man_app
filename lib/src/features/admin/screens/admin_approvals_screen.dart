import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/admin_controller.dart';

class AdminApprovalsScreen extends ConsumerWidget {
  const AdminApprovalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final approvalsAsync = ref.watch(adminApprovalsControllerProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Approvals', style: TextStyle(fontWeight: FontWeight.w600)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Vendor Approvals'),
              Tab(text: 'Driver Approvals'),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: approvalsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (approvals) => TabBarView(
            children: [
              _VendorApprovalsTab(vendors: approvals['vendors']!),
              _DriverApprovalsTab(drivers: approvals['drivers']!),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorApprovalsTab extends ConsumerWidget {
  final List<Map<String, dynamic>> vendors;
  const _VendorApprovalsTab({required this.vendors});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: vendors.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final vendor = vendors[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              title: Text(vendor['name'] ?? vendor['company_name'] ?? 'Unknown'),
              subtitle: Text('${vendor['email']}\nStatus: ${vendor['status']}'),
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
                          title: const Text('Approve Vendor'),
                          content: Text('Approve ${vendor['name'] ?? vendor['company_name']}?'),
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
                        await ref.read(adminApprovalsControllerProvider.notifier).approveVendor(vendor['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vendor approved!')),
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
                          title: const Text('Reject Vendor'),
                          content: Text('Reject ${vendor['name'] ?? vendor['company_name']}?'),
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
                        await ref.read(adminApprovalsControllerProvider.notifier).rejectVendor(vendor['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Vendor rejected!')),
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
    );
  }
}

class _DriverApprovalsTab extends ConsumerWidget {
  final List<Map<String, dynamic>> drivers;
  const _DriverApprovalsTab({required this.drivers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: ListView.separated(
        padding: const EdgeInsets.all(24.0),
        itemCount: drivers.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final driver = drivers[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              title: Text(driver['name'] ?? 'Unknown'),
              subtitle: Text('${driver['email']}\nStatus: ${driver['status']}'),
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
                          title: const Text('Approve Driver'),
                          content: Text('Approve ${driver['name']}?'),
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
                        await ref.read(adminApprovalsControllerProvider.notifier).approveDriver(driver['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Driver approved!')),
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
                          title: const Text('Reject Driver'),
                          content: Text('Reject ${driver['name']}?'),
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
                        await ref.read(adminApprovalsControllerProvider.notifier).rejectDriver(driver['id']);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Driver rejected!')),
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
    );
  }
}
