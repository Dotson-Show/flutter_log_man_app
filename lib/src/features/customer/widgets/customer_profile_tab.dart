// FILE: lib/features/customer/widgets/customer_profile_tab.dart
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../../widgets/settings_section.dart';
import '../../../widgets/settings_list_tile.dart';
import '../../../widgets/logout_button.dart';

class CustomerProfileTab extends ConsumerWidget {
  const CustomerProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        centerTitle: true,
      ),
      body: userAsync.when(
        data: (user) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      (user?.username ?? "C").substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.username ?? "Customer",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? "customer@example.com",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SettingsSection(
              children: [
                SettingsListTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.payment,
                  title: 'Payment Methods',
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.security_outlined,
                  title: 'Security',
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.help_outline,
                  title: 'Help & Support',
                  onTap: () {},
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 16),
            SettingsSection(
              children: [
                SettingsListTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                SettingsListTile(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () {},
                  showDivider: false,
                ),
              ],
            ),
            const SizedBox(height: 24),
            const LogoutFilledButton(),
            const SizedBox(height: 16),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64),
              const SizedBox(height: 16),
              Text(
                'Error loading profile',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}