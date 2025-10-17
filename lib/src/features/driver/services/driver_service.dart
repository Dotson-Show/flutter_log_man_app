import '../../../core/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../../../models/journey.dart';
import '../../../models/waybill.dart';
import '../../../models/payment.dart';
import '../../../utils/error_parser.dart';

part 'driver_service.g.dart';

class DriverService {
  final ApiClient apiClient;
  DriverService(this.apiClient);

  Future<void> registerDriver({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String licenseDocPath,
    required String vehicleDocPath,
  }) async {
    try {
      await apiClient.dio.post('/auth/register', data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'license_doc': licenseDocPath,
        'vehicle_doc': vehicleDocPath,
        'user_type': 'DRIVER',
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<Journey>> fetchDriverJourneys() async {
    try {
      final res = await apiClient.dio.get('/api/v1/journeys', queryParameters: {'role': 'driver'});
      final items = res.data['items'] as List;
      return items.map((e) => Journey.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> updateJourneyStatus({required int journeyId, required String status}) async {
    try {
      await apiClient.dio.put('/api/v1/journeys/$journeyId/update-status', data: {'status': status});
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> uploadProof({required int journeyId, required String filePath}) async {
    final formData = FormData.fromMap({
      'journey_id': journeyId,
      'document': await MultipartFile.fromFile(filePath),
    });
    try {
      await apiClient.dio.post('/api/v1/waybills/upload', data: formData);
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<Payment>> fetchDriverPayments() async {
    try {
      final res = await apiClient.dio.get('/api/v1/payments', queryParameters: {'role': 'driver'});
      final items = res.data['items'] as List;
      return items.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> confirmPayment({required int paymentId}) async {
    try {
      await apiClient.dio.put('/api/v1/payments/$paymentId/confirm');
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<Map<String, dynamic>> fetchDriverAnalytics() async {
    try {
      final res = await apiClient.dio.get('/api/v1/driver/analytics');
      return res.data;
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }
}

@riverpod
DriverService driverService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DriverService(apiClient);
}




