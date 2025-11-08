// FILE: lib/features/merchant/controllers/merchant_controller.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'merchant_controller.g.dart';

@riverpod
class MerchantAnalyticsController extends _$MerchantAnalyticsController {
  @override
  Future<Map<String, dynamic>> build() async {
    // Simulate API call - replace with actual API
    await Future.delayed(const Duration(seconds: 1));

    return {
      'pending_deliveries': 3,
      'in_transit': 2,
      'confirmed_deliveries': 40,
      'active_disputes': 1,
      'total_deliveries': 45,
      'on_time_percentage': 95.0,
    };
  }
}