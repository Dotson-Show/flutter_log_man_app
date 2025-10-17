import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../controllers/admin_controller.dart';
import '../../../models/user.dart';

class AdminUsersScreen extends ConsumerWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(adminUsersControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management', style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: usersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (users) => ListView.separated(
            padding: const EdgeInsets.all(24.0),
            itemCount: users.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final User user = users[index];
              final isActive = user.isPhoneVerified ?? false; // Using isPhoneVerified as status indicator
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  title: Text(user.username),
                  subtitle: Text(
                    '${user.email}\nType: ${user.userType}\nStatus: ${isActive ? 'ACTIVE' : 'INACTIVE'}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.visibility),
                        tooltip: 'View Details',
                        onPressed: () => Navigator.pushNamed(context, '/admin/user-detail', arguments: user.id),
                      ),
                      if (user.userType == 'ADMIN')
                        IconButton(
                          icon: const Icon(Icons.admin_panel_settings),
                          tooltip: 'Manage Roles',
                          onPressed: () => Navigator.pushNamed(context, '/admin/manage-roles', arguments: user.id),
                        ),
                      IconButton(
                        icon: Icon(
                          isActive ? Icons.block : Icons.check_circle,
                          color: isActive ? Colors.red : Colors.green,
                        ),
                        tooltip: isActive ? 'Deactivate' : 'Activate',
                        onPressed: () async {
                          final action = isActive ? 'deactivate' : 'activate';
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('$action User'),
                              content: Text('Are you sure you want to $action ${user.username}?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: const Text('Cancel'),
                                ),
                                FilledButton(
                                  onPressed: () => Navigator.of(context).pop(true),
                                  child: Text(action),
                                ),
                              ],
                            ),
                          );
                          if (confirmed == true) {
                            if (isActive) {
                              await ref.read(adminUsersControllerProvider.notifier).deactivateUser(user.id);
                            } else {
                              await ref.read(adminUsersControllerProvider.notifier).activateUser(user.id);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('User ${action}d!')),
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
        ),
      ),
    );
  }
}
