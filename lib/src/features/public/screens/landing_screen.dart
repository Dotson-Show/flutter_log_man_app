import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class LandingScreen extends HookWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);

    return Scaffold(
      backgroundColor: const Color(0xFFCDD1D1),
      body: SafeArea(
        child: Column(
          children: [
            // Header with skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                      'assets/images/revoltrans_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF1F1F1F),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Page View with onboarding slides
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  currentPage.value = index;
                },
                children: [
                  _OnboardingSlide(
                    icon: Icons.local_shipping_rounded,
                    title: 'Move Everything, Forward',
                    description: 'Connect with reliable logistics partners and manage your shipments seamlessly',
                    imagePath: 'assets/images/onboarding_1.png',
                  ),
                  _OnboardingSlide(
                    icon: Icons.person_add_rounded,
                    title: 'Become World\'s Transporter',
                    description: 'Join our network of drivers and vendors to grow your business',
                    imagePath: 'assets/images/onboarding_2.png',
                  ),
                  _OnboardingSlide(
                    icon: Icons.trending_up_rounded,
                    title: 'Get Better Rates',
                    description: 'Competitive pricing and transparent billing for all your logistics needs',
                    imagePath: 'assets/images/onboarding_3.png',
                  ),
                ],
              ),
            ),
            // Dots indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                      (index) => TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 300),
                    tween: Tween(
                      begin: index == currentPage.value ? 24.0 : 8.0,
                      end: index == currentPage.value ? 24.0 : 8.0,
                    ),
                    builder: (context, value, child) {
                      return Container(
                        height: 8,
                        width: value,
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: index == currentPage.value
                              ? const Color(0xFF1F1F1F)
                              : const Color(0xFF1F1F1F).withOpacity(0.3),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // Bottom buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Get Started button
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1F1F1F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () => context.go('/register'),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Already have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF666666),
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F1F1F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? imagePath;

  const _OnboardingSlide({
    required this.icon,
    required this.title,
    required this.description,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            child: imagePath != null
                ? Image.asset(imagePath!, fit: BoxFit.cover)
                : Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  size: 100,
                  color: const Color(0xFF1F1F1F),
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F1F1F),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: const Color(0xFF666666),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}