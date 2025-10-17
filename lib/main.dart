import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:app_links/app_links.dart';
import 'dart:async';

// Auth
import 'src/features/auth/controllers/auth_controller.dart';

// Features
import 'src/features/splash/screens/splash_screen.dart';
import 'src/features/public/screens/landing_screen.dart';
import 'src/features/auth/screens/login_screen.dart';
import 'src/features/auth/screens/register_screen.dart';
import 'src/features/auth/screens/verify_screen.dart';
import 'src/widgets/dashboard_router.dart';

// Customer features
import 'src/features/customer/screens/customer_dashboard_screen.dart';
import 'src/features/customer/screens/journey_detail_screen.dart';
import 'src/features/customer/screens/customer_create_request_screen.dart';
import 'src/features/customer/screens/history_screen.dart';

// Vendor features
import 'src/features/vendor/screens/vendor_onboarding_screen.dart';
import 'src/features/vendor/screens/vendor_dashboard_screen.dart';
import 'src/features/vendor/screens/vendor_requests_screen.dart';
import 'src/features/vendor/screens/vendor_assign_driver_screen.dart';
import 'src/features/vendor/screens/vendor_journey_detail_screen.dart';
import 'src/features/vendor/screens/vendor_waybill_screen.dart';
import 'src/features/vendor/screens/vendor_analytics_screen.dart';

// Driver features
import 'src/features/driver/screens/driver_onboarding_screen.dart';
import 'src/features/driver/screens/driver_dashboard_screen.dart';
import 'src/features/driver/screens/driver_journeys_screen.dart';
import 'src/features/driver/screens/driver_journey_detail_screen.dart';
import 'src/features/driver/screens/driver_update_status_screen.dart';
import 'src/features/driver/screens/driver_waybill_upload_screen.dart';
import 'src/features/driver/screens/driver_payments_screen.dart';
import 'src/features/driver/screens/driver_live_location_screen.dart';

// Admin features
import 'src/features/admin/screens/admin_dashboard_screen.dart';
import 'src/features/admin/screens/admin_approvals_screen.dart';
import 'src/features/admin/screens/admin_payments_screen.dart';
import 'src/features/admin/screens/admin_users_screen.dart';
import 'src/features/admin/screens/admin_analytics_screen.dart';

void main() {
  runApp(const ProviderScope(child: RevoltransApp()));
}

class RevoltransApp extends ConsumerStatefulWidget {
  const RevoltransApp({super.key});

  @override
  ConsumerState<RevoltransApp> createState() => _RevoltransAppState();
}

class _RevoltransAppState extends ConsumerState<RevoltransApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSubscription;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _setupRouter();
    _initDeepLinks();
  }

  void _setupRouter() {
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        // Splash
        GoRoute(
          path: '/',
          builder: (_, __) => const SplashScreen(),
        ),

        // Public routes
        GoRoute(
          path: '/landing',
          builder: (_, __) => const LandingScreen(),
        ),

        // Auth routes 
        GoRoute(
          path: '/login',
          builder: (_, __) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (_, __) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/verify',
          builder: (_, __) => const VerifyScreen(),
        ),
        // Dashboard router - automatically routes to correct dashboard
        GoRoute(
          path: '/dashboard',
          builder: (_, __) => const DashboardRouter(),
        ),

        // Customer routes
        GoRoute(
          path: '/dashboard/customer',
          builder: (_, __) => const CustomerDashboardScreen(),
        ),
        GoRoute(
          path: '/customer/create-request',
          builder: (_, __) => const CustomerCreateRequestScreen(),
        ),
        GoRoute(
          path: '/customer/history',
          builder: (_, __) => const HistoryScreen(),
        ),
        GoRoute(
          path: '/customer/journey/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            if (id == null) throw Exception('Journey ID is required');
            return JourneyDetailScreen(
              journeyId: int.parse(id),
            );
          },
        ),

        // Vendor routes
        GoRoute(
          path: '/vendor/onboarding',
          builder: (_, __) => const VendorOnboardingScreen(),
        ),
        GoRoute(
          path: '/vendor/dashboard',
          builder: (_, __) => const VendorDashboardScreen(),
        ),
        GoRoute(
          path: '/vendor/requests',
          builder: (_, __) => const VendorRequestsScreen(),
        ),
        GoRoute(
          path: '/vendor/assign-driver',
          builder: (context, state) => VendorAssignDriverScreen(
            journeyId: state.extra is int ? state.extra as int : int.parse(state.extra as String),
          ),
        ),
        GoRoute(
          path: '/vendor/journey/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            if (id == null) throw Exception('Journey ID is required');
            return VendorJourneyDetailScreen(
              journeyId: int.parse(id),
            );
          },
        ),
        GoRoute(
          path: '/vendor/waybill',
          builder: (_, __) => const VendorWaybillScreen(),
        ),
        GoRoute(
          path: '/vendor/analytics',
          builder: (_, __) => const VendorAnalyticsScreen(),
        ),

        // Driver routes
        GoRoute(
          path: '/driver/onboarding',
          builder: (_, __) => const DriverOnboardingScreen(),
        ),
        GoRoute(
          path: '/driver/dashboard',
          builder: (_, __) => const DriverDashboardScreen(),
        ),
        GoRoute(
          path: '/driver/journeys',
          builder: (_, __) => const DriverJourneysScreen(),
        ),
        GoRoute(
          path: '/driver/journey/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            if (id == null) throw Exception('Journey ID is required');
            return DriverJourneyDetailScreen(
              journeyId: int.parse(id),
            );
          },
        ),
        GoRoute(
          path: '/driver/update-status',
          builder: (context, state) => DriverUpdateStatusScreen(
            journeyId: state.extra is int ? state.extra as int : int.parse(state.extra as String),
          ),
        ),
        GoRoute(
          path: '/driver/upload-proof',
          builder: (_, __) => const DriverWaybillUploadScreen(),
        ),
        GoRoute(
          path: '/driver/payments',
          builder: (_, __) => const DriverPaymentsScreen(),
        ),
        GoRoute(
          path: '/driver/live-location',
          builder: (_, __) => const DriverLiveLocationScreen(),
        ),

        // Admin routes
        GoRoute(
          path: '/admin/dashboard',
          builder: (_, __) => const AdminDashboardScreen(),
        ),
        GoRoute(
          path: '/admin/approvals',
          builder: (_, __) => const AdminApprovalsScreen(),
        ),
        GoRoute(
          path: '/admin/payments',
          builder: (_, __) => const AdminPaymentsScreen(),
        ),
        GoRoute(
          path: '/admin/users',
          builder: (_, __) => const AdminUsersScreen(),
        ),
        GoRoute(
          path: '/admin/analytics',
          builder: (_, __) => const AdminAnalyticsScreen(),
        ),
        GoRoute(
          path: '/admin/user-detail/:id',
          builder: (context, state) => const Placeholder(), // TODO: Implement user detail screen
        ),
        GoRoute(
          path: '/admin/manage-roles/:id',
          builder: (context, state) => const Placeholder(), // TODO: Implement role management screen
        ),

        // Generic journey route (for deep links)
        GoRoute(
          path: '/journey/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'];
            if (id == null) throw Exception('Journey ID is required');
            return JourneyDetailScreen(
              journeyId: int.parse(id),
            );
          },
        ),
      ],
      redirect: (context, state) async {
        // Auth guard logic
        try {
          final container = ProviderScope.containerOf(context);
          final isAuth = await container.read(isAuthenticatedProvider.future);

          final currentPath = state.matchedLocation;
          final isPublicRoute = _isPublicRoute(currentPath);
          final isAuthRoute = _isAuthRoute(currentPath);

          // Not authenticated and trying to access protected route
          if (!isAuth && !isPublicRoute) {
            return '/login';
          }

          // Authenticated and trying to access auth pages
          if (isAuth && isAuthRoute) {
            return '/dashboard';
          }
        } catch (e) {
          debugPrint('Auth guard error: $e');
        }

        return null; // Allow navigation
      },
    );
  }

  bool _isPublicRoute(String path) {
    const publicRoutes = ['/', '/landing', '/login', '/register', '/verify'];
    return publicRoutes.contains(path);
  }

  bool _isAuthRoute(String path) {
    const authRoutes = ['/login', '/register'];
    return authRoutes.contains(path);
  }

  void _initDeepLinks() async {
    // Handle incoming links when app is already running
    _linkSubscription = _appLinks.uriLinkStream.listen(
          (Uri uri) {
        _handleDeepLink(uri);
      },
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );

    // Handle link when app is launched from terminated state
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink);
      }
    } catch (e) {
      debugPrint('Failed to get initial link: $e');
    }
  }

  void _handleDeepLink(Uri uri) {
    debugPrint('Received deep link: $uri');

    // Extract the path from the URI
    String path = uri.path;

    // Handle query parameters if needed
    Map<String, String> queryParams = uri.queryParameters;

    try {
      // Use GoRouter to navigate to the deep link path
      if (_isValidRoute(path)) {
        // Add any query parameters as extra data if needed
        if (queryParams.isNotEmpty) {
          _router.go(path, extra: queryParams);
        } else {
          _router.go(path);
        }
      } else {
        // If route doesn't exist, redirect to landing or dashboard
        debugPrint('Invalid route: $path, redirecting to landing');
        _router.go('/landing');
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
      // Fallback to landing page
      _router.go('/landing');
    }
  }

  bool _isValidRoute(String path) {
    // List of valid routes in your app
    const validRoutes = [
      '/',
      '/landing',
      '/login',
      '/register',
      '/verify',
      '/dashboard',
      '/dashboard/customer',
      '/customer/create-request',
      '/customer/history',
      '/vendor/onboarding',
      '/vendor/dashboard',
      '/vendor/requests',
      '/vendor/waybill',
      '/vendor/analytics',
      '/driver/onboarding',
      '/driver/dashboard',
      '/driver/journeys',
      '/driver/upload-proof',
      '/driver/payments',
      '/driver/live-location',
      '/admin/dashboard',
      '/admin/approvals',
      '/admin/payments',
      '/admin/users',
      '/admin/analytics',
    ];

    // Check exact matches
    if (validRoutes.contains(path)) return true;

    // Check pattern matches
    if (RegExp(r'^/journey/\d+$').hasMatch(path)) return true;
    if (RegExp(r'^/customer/journey/\d+$').hasMatch(path)) return true;
    if (RegExp(r'^/vendor/journey/\d+$').hasMatch(path)) return true;
    if (RegExp(r'^/driver/journey/\d+$').hasMatch(path)) return true;
    if (RegExp(r'^/admin/user-detail/\d+$').hasMatch(path)) return true;
    if (RegExp(r'^/admin/manage-roles/\d+$').hasMatch(path)) return true;

    return false;
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Revoltrans',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routerConfig: _router,
    );
  }
}