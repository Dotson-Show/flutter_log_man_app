import '../../../core/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../models/user.dart';
import '../../../models/payment.dart';
import 'package:dio/dio.dart';
import '../../../utils/error_parser.dart';

part 'admin_service.g.dart';

class AdminService {
  final ApiClient apiClient;
  AdminService(this.apiClient);

  Future<List<Map<String, dynamic>>> fetchVendorApprovals() async {
    try {
      final res = await apiClient.dio.get('/api/v1/admin/approvals/vendors');
      final items = res.data['items'] as List;
      return items.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<Map<String, dynamic>>> fetchDriverApprovals() async {
    try {
      final res = await apiClient.dio.get('/api/v1/admin/approvals/drivers');
      final items = res.data['items'] as List;
      return items.cast<Map<String, dynamic>>();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> approveVendor(int vendorId, String status, {String? message}) async {
    try {
      await apiClient.dio.put('/api/v1/admin/approvals/vendors/$vendorId', data: {
        'status': status,
        if (message != null) 'message': message,
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> approveDriver(int driverId, String status, {String? message}) async {
    try {
      await apiClient.dio.put('/api/v1/admin/approvals/drivers/$driverId', data: {
        'status': status,
        if (message != null) 'message': message,
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<Payment>> fetchPaymentRequests() async {
    try {
      final res = await apiClient.dio.get('/api/v1/admin/approvals/payment-requests');
      final items = res.data['items'] as List;
      return items.map((e) => Payment.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> approvePayment(int paymentId, String status, {String? message}) async {
    try {
      await apiClient.dio.put('/api/v1/admin/approvals/payment-requests/$paymentId', data: {
        'status': status,
        if (message != null) 'message': message,
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<List<User>> fetchUsers() async {
    try {
      final res = await apiClient.dio.get('/api/v1/admin/users');
      final items = res.data['items'] as List;
      return items.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<void> updateUserStatus(int userId, String status) async {
    try {
      await apiClient.dio.put('/api/v1/admin/users/$userId/status', data: {
        'status': status,
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  Future<Map<String, dynamic>> fetchAdminAnalytics() async {
    try {
      final res = await apiClient.dio.get('/api/v1/admin/analytics');
      return res.data;
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }
}

@riverpod
AdminService adminService(Ref ref) {
  final apiClient = ref.watch(apiClientProvider);
  return AdminService(apiClient);
}




