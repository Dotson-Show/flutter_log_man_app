import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/controllers/auth_controller.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 2), () async {
        if (context.mounted) {
          try {
            final isAuthenticated = await ref.read(isAuthenticatedProvider.future);
            if (context.mounted) {
              if (isAuthenticated) {
                context.go('/dashboard');
              } else {
                context.go('/landing');
              }
            }
          } catch (e) {
            if (context.mounted) {
              context.go('/landing');
            }
          }
        }
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: const Color(0xFFCDD1D1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo with animated appearance
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.local_shipping_rounded,
                  size: 60,
                  color: Color(0xFF1F1F1F),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Revoltrans',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F1F1F),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Logistics Management System',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF666666),
              ),
            ),
            const SizedBox(height: 48),
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 1200),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(opacity: value, child: child);
              },
              child: const SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1F1F1F)),
                  strokeWidth: 3,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Loading...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(0xFF999999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}