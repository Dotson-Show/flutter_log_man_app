// lib/src/widgets/dashboard_header.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/controllers/auth_controller.dart';

/// Reusable dashboard header with avatar, user info, and centered title
class DashboardHeader extends ConsumerWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final List<Widget>? actions;
  final bool showNotifications;

  const DashboardHeader({
    required this.title,
    required this.backgroundColor,
    required this.foregroundColor,
    this.actions,
    this.showNotifications = true,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);

    return SliverAppBar.large(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: backgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        if (showNotifications)
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            tooltip: 'Notifications',
          ),
        ...(actions ?? []),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: _buildFlexibleSpaceBackground(context, backgroundColor, foregroundColor, userAsync),
      ),
    );
  }

  Widget _buildFlexibleSpaceBackground(
      BuildContext context,
      Color bgColor,
      Color fgColor,
      AsyncValue userAsync,
      ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [bgColor, bgColor.withOpacity(0.7)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -40,
            top: -40,
            child: Opacity(
              opacity: 0.1,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: fgColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 60,
            child: userAsync.when(
              data: (user) => Row(
                children: [
                  GestureDetector(
                    onTap: () => context.push('/profile'),
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 32,
                        backgroundColor: fgColor.withOpacity(0.3),
                        child: Text(
                          user?.username?.substring(0, 1).toUpperCase() ?? 'U',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.username ?? 'User',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        user?.email ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}