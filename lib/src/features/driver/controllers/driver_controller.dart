import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/driver_service.dart';
import '../../../models/journey.dart';
import '../../../models/payment.dart';

part 'driver_controller.g.dart';

@riverpod
class DriverOnboardingController extends _$DriverOnboardingController {
  @override
  AsyncValue<void> build() {
    return const AsyncValue.data(null);
  }

  Future<void> registerDriver({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String licenseDocPath,
    required String vehicleDocPath,
  }) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(driverServiceProvider).registerDriver(
        name: name,
        email: email,
        phone: phone,
        password: password,
        licenseDocPath: licenseDocPath,
        vehicleDocPath: vehicleDocPath,
      );
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
class DriverJourneysController extends _$DriverJourneysController {
  @override
  Future<List<Journey>> build() async {
    return ref.read(driverServiceProvider).fetchDriverJourneys();
  }

  Future<void> acceptJourney(int journeyId) async {
    await ref.read(driverServiceProvider).updateJourneyStatus(journeyId: journeyId, status: 'accepted');
    state = const AsyncLoading();
    state = AsyncData(await ref.read(driverServiceProvider).fetchDriverJourneys());
  }

  Future<void> declineJourney(int journeyId) async {
    await ref.read(driverServiceProvider).updateJourneyStatus(journeyId: journeyId, status: 'declined');
    state = const AsyncLoading();
    state = AsyncData(await ref.read(driverServiceProvider).fetchDriverJourneys());
  }

  Future<void> updateJourneyStatus(int journeyId, String status) async {
    await ref.read(driverServiceProvider).updateJourneyStatus(journeyId: journeyId, status: status);
    state = const AsyncLoading();
    state = AsyncData(await ref.read(driverServiceProvider).fetchDriverJourneys());
  }
}

@riverpod
class DriverPaymentsController extends _$DriverPaymentsController {
  @override
  Future<List<Payment>> build() async {
    return ref.read(driverServiceProvider).fetchDriverPayments();
  }

  Future<void> confirmPayment(int paymentId) async {
    await ref.read(driverServiceProvider).confirmPayment(paymentId: paymentId);
    state = const AsyncLoading();
    state = AsyncData(await ref.read(driverServiceProvider).fetchDriverPayments());
  }
}

@riverpod
class DriverAnalyticsController extends _$DriverAnalyticsController {
  @override
  Future<Map<String, dynamic>> build() async {
    return ref.read(driverServiceProvider).fetchDriverAnalytics();
  }
}




