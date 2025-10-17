import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationHelper {
  // Customer routes
  static void goToCustomerDashboard(BuildContext context) {
    context.go('/dashboard/customer');
  }

  static void goToCreateRequest(BuildContext context) {
    context.go('/customer/create-request');
  }

  static void goToCustomerHistory(BuildContext context) {
    context.go('/customer/history');
  }

  static void goToCustomerJourneyDetail(BuildContext context, int journeyId) {
    context.go('/customer/journey/$journeyId');
  }

  // Vendor routes
  static void goToVendorOnboarding(BuildContext context) {
    context.go('/vendor/onboarding');
  }

  static void goToVendorDashboard(BuildContext context) {
    context.go('/vendor/dashboard');
  }

  static void goToVendorRequests(BuildContext context) {
    context.go('/vendor/requests');
  }

  static void goToVendorAssignDriver(BuildContext context, int journeyId) {
    context.go('/vendor/assign-driver', extra: journeyId);
  }

  static void goToVendorJourneyDetail(BuildContext context, int journeyId) {
    context.go('/vendor/journey/$journeyId');
  }

  static void goToVendorWaybill(BuildContext context) {
    context.go('/vendor/waybill');
  }

  static void goToVendorAnalytics(BuildContext context) {
    context.go('/vendor/analytics');
  }

  // Driver routes
  static void goToDriverOnboarding(BuildContext context) {
    context.go('/driver/onboarding');
  }

  static void goToDriverDashboard(BuildContext context) {
    context.go('/driver/dashboard');
  }

  static void goToDriverJourneys(BuildContext context) {
    context.go('/driver/journeys');
  }

  static void goToDriverJourneyDetail(BuildContext context, int journeyId) {
    context.go('/driver/journey/$journeyId');
  }

  static void goToDriverUpdateStatus(BuildContext context, int journeyId) {
    context.go('/driver/update-status', extra: journeyId);
  }

  static void goToDriverUploadProof(BuildContext context) {
    context.go('/driver/upload-proof');
  }

  static void goToDriverPayments(BuildContext context) {
    context.go('/driver/payments');
  }

  // Admin routes
  static void goToAdminDashboard(BuildContext context) {
    context.go('/admin/dashboard');
  }

  static void goToAdminApprovals(BuildContext context) {
    context.go('/admin/approvals');
  }

  static void goToAdminPayments(BuildContext context) {
    context.go('/admin/payments');
  }

  static void goToAdminUsers(BuildContext context) {
    context.go('/admin/users');
  }

  static void goToAdminAnalytics(BuildContext context) {
    context.go('/admin/analytics');
  }

  static void goToAdminUserDetail(BuildContext context, int userId) {
    context.go('/admin/user-detail/$userId');
  }

  static void goToAdminManageRoles(BuildContext context, int userId) {
    context.go('/admin/manage-roles/$userId');
  }

  // Auth routes
  static void goToLogin(BuildContext context) {
    context.go('/login');
  }

  static void goToRegister(BuildContext context) {
    context.go('/register');
  }

  static void goToVerify(BuildContext context) {
    context.go('/verify');
  }

  static void goToLanding(BuildContext context) {
    context.go('/landing');
  }

  // Generic journey route (for deep links)
  static void goToJourneyDetail(BuildContext context, int journeyId) {
    context.go('/journey/$journeyId');
  }

  // Navigation with replacement (no back button)
  static void replaceToCustomerDashboard(BuildContext context) {
    context.go('/dashboard/customer');
  }

  static void replaceToVendorDashboard(BuildContext context) {
    context.go('/vendor/dashboard');
  }

  static void replaceToDriverDashboard(BuildContext context) {
    context.go('/driver/dashboard');
  }

  static void replaceToAdminDashboard(BuildContext context) {
    context.go('/admin/dashboard');
  }

  // Pop current screen
  static void pop(BuildContext context) {
    context.pop();
  }

  // Pop until specific route
  static void popUntil(BuildContext context, String route) {
    context.go(route);
  }
}
