import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/admin_service.dart';
import '../../../models/user.dart';
import '../../../models/payment.dart';

part 'admin_controller.g.dart';

@riverpod
class AdminApprovalsController extends _$AdminApprovalsController {
  @override
  Future<Map<String, List<Map<String, dynamic>>>> build() async {
    final vendorApprovals = await ref.read(adminServiceProvider).fetchVendorApprovals();
    final driverApprovals = await ref.read(adminServiceProvider).fetchDriverApprovals();
    return {
      'vendors': vendorApprovals,
      'drivers': driverApprovals,
    };
  }

  Future<void> approveVendor(int vendorId, {String? message}) async {
    await ref.read(adminServiceProvider).approveVendor(vendorId, 'APPROVED', message: message);
    state = const AsyncLoading();
    final vendorApprovals = await ref.read(adminServiceProvider).fetchVendorApprovals();
    final driverApprovals = await ref.read(adminServiceProvider).fetchDriverApprovals();
    state = AsyncData({
      'vendors': vendorApprovals,
      'drivers': driverApprovals,
    });
  }

  Future<void> rejectVendor(int vendorId, {String? message}) async {
    await ref.read(adminServiceProvider).approveVendor(vendorId, 'REJECTED', message: message);
    state = const AsyncLoading();
    final vendorApprovals = await ref.read(adminServiceProvider).fetchVendorApprovals();
    final driverApprovals = await ref.read(adminServiceProvider).fetchDriverApprovals();
    state = AsyncData({
      'vendors': vendorApprovals,
      'drivers': driverApprovals,
    });
  }

  Future<void> approveDriver(int driverId, {String? message}) async {
    await ref.read(adminServiceProvider).approveDriver(driverId, 'APPROVED', message: message);
    state = const AsyncLoading();
    final vendorApprovals = await ref.read(adminServiceProvider).fetchVendorApprovals();
    final driverApprovals = await ref.read(adminServiceProvider).fetchDriverApprovals();
    state = AsyncData({
      'vendors': vendorApprovals,
      'drivers': driverApprovals,
    });
  }

  Future<void> rejectDriver(int driverId, {String? message}) async {
    await ref.read(adminServiceProvider).approveDriver(driverId, 'REJECTED', message: message);
    state = const AsyncLoading();
    final vendorApprovals = await ref.read(adminServiceProvider).fetchVendorApprovals();
    final driverApprovals = await ref.read(adminServiceProvider).fetchDriverApprovals();
    state = AsyncData({
      'vendors': vendorApprovals,
      'drivers': driverApprovals,
    });
  }
}

@riverpod
class AdminPaymentsController extends _$AdminPaymentsController {
  @override
  Future<List<Payment>> build() async {
    return ref.read(adminServiceProvider).fetchPaymentRequests();
  }

  Future<void> approvePayment(int paymentId, {String? message}) async {
    await ref.read(adminServiceProvider).approvePayment(paymentId, 'APPROVED', message: message);
    state = const AsyncLoading();
    state = AsyncData(await ref.read(adminServiceProvider).fetchPaymentRequests());
  }

  Future<void> rejectPayment(int paymentId, {String? message}) async {
    await ref.read(adminServiceProvider).approvePayment(paymentId, 'REJECTED', message: message);
    state = const AsyncLoading();
    state = AsyncData(await ref.read(adminServiceProvider).fetchPaymentRequests());
  }
}

@riverpod
class AdminUsersController extends _$AdminUsersController {
  @override
  Future<List<User>> build() async {
    return ref.read(adminServiceProvider).fetchUsers();
  }

  Future<void> activateUser(int userId) async {
    await ref.read(adminServiceProvider).updateUserStatus(userId, 'ACTIVE');
    state = const AsyncLoading();
    state = AsyncData(await ref.read(adminServiceProvider).fetchUsers());
  }

  Future<void> deactivateUser(int userId) async {
    await ref.read(adminServiceProvider).updateUserStatus(userId, 'INACTIVE');
    state = const AsyncLoading();
    state = AsyncData(await ref.read(adminServiceProvider).fetchUsers());
  }
}

@riverpod
class AdminAnalyticsController extends _$AdminAnalyticsController {
  @override
  Future<Map<String, dynamic>> build() async {
    return ref.read(adminServiceProvider).fetchAdminAnalytics();
  }
}




