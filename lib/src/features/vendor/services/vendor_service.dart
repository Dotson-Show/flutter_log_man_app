import '../../../core/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';
import '../../../models/journey.dart';
import '../../../models/waybill.dart';
import '../../../models/user.dart';
import '../../../utils/error_parser.dart';

part 'vendor_service.g.dart';

class VendorService {
  final ApiClient apiClient;
  VendorService(this.apiClient);

  Future<void> registerVendor({
    required String companyName,
    required String taxId,
    required String businessLicense,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      await apiClient.dio.post('/auth/register', data: {
        'company_name': companyName,
        'tax_id': taxId,
        'business_license': businessLicense,
        'email': email,
        'phone': phone,
        'password': password,
        'user_type': 'VENDOR',
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<Journey>> fetchVendorRequests() async {
    try {
      final res = await apiClient.dio.get('/journeys', queryParameters: {'role': 'vendor'});
      final items = res.data['items'] as List;
      return items.map((e) => Journey.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> updateRequestStatus({required int journeyId, required String status}) async {
    try {
      await apiClient.dio.put('/journeys/$journeyId/update-status', data: {'status': status});
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> assignDriver({required int journeyId, required int driverId}) async {
    try {
      await apiClient.dio.put('/journeys/$journeyId/assign-driver', data: {'driver_id': driverId});
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<User>> fetchDrivers() async {
    try {
      final res = await apiClient.dio.get('/vendor/drivers');
      final items = res.data['items'] as List;
      return items.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> uploadWaybill({required int journeyId, required String filePath}) async {
    final formData = FormData.fromMap({
      'journey_id': journeyId,
      'document': await MultipartFile.fromFile(filePath),
    });
    await apiClient.dio.post('/waybills/upload', data: formData);
  }

  Future<List<Waybill>> fetchWaybills() async {
    final res = await apiClient.dio.get('/waybills', queryParameters: {'role': 'vendor'});
    final items = res.data['items'] as List;
    return items.map((e) => Waybill.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> fetchAnalytics() async {
    final res = await apiClient.dio.get('/vendors/analytics');
    return res.data;
  }
}

@riverpod
VendorService vendorService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return VendorService(apiClient);
}
