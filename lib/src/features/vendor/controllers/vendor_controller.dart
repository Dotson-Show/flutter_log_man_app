import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/vendor_service.dart';
import '../../../models/journey.dart';
import '../../../models/user.dart';
import '../../../models/waybill.dart';

part 'vendor_controller.g.dart';

@riverpod
class VendorOnboardingController extends _$VendorOnboardingController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> registerVendor({
    required String companyName,
    required String taxId,
    required String businessLicense,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(vendorServiceProvider).registerVendor(
        companyName: companyName,
        taxId: taxId,
        businessLicense: businessLicense,
        email: email,
        phone: phone,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
class VendorRequestsController extends _$VendorRequestsController {
  @override
  Future<List<Journey>> build() async {
    return ref.read(vendorServiceProvider).fetchVendorRequests();
  }

  Future<void> acceptRequest(int journeyId) async {
    await ref.read(vendorServiceProvider).updateRequestStatus(journeyId: journeyId, status: 'accepted');
    state = const AsyncLoading();
    state = AsyncData(await ref.read(vendorServiceProvider).fetchVendorRequests());
  }

  Future<void> rejectRequest(int journeyId) async {
    await ref.read(vendorServiceProvider).updateRequestStatus(journeyId: journeyId, status: 'rejected');
    state = const AsyncLoading();
    state = AsyncData(await ref.read(vendorServiceProvider).fetchVendorRequests());
  }

  Future<void> assignDriver(int journeyId, int driverId) async {
    await ref.read(vendorServiceProvider).assignDriver(journeyId: journeyId, driverId: driverId);
    state = const AsyncLoading();
    state = AsyncData(await ref.read(vendorServiceProvider).fetchVendorRequests());
  }
}

@riverpod
class VendorDriversController extends _$VendorDriversController {
  @override
  Future<List<User>> build() async {
    return ref.read(vendorServiceProvider).fetchDrivers();
  }
}

@riverpod
class VendorWaybillsController extends _$VendorWaybillsController {
  @override
  Future<List<Waybill>> build() async {
    return ref.read(vendorServiceProvider).fetchWaybills();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncData(await ref.read(vendorServiceProvider).fetchWaybills());
  }

  Future<void> uploadWaybill(int journeyId, String filePath) async {
    await ref.read(vendorServiceProvider).uploadWaybill(journeyId: journeyId, filePath: filePath);
    await refresh();
  }
}

@riverpod
class VendorAnalyticsController extends _$VendorAnalyticsController {
  @override
  Future<Map<String, dynamic>> build() async {
    return ref.read(vendorServiceProvider).fetchAnalytics();
  }
}
