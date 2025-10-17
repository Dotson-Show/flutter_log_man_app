import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_service_factory.dart';

part 'mock_usage_example.g.dart';

/// Example of how to use the mock API service in your controllers
/// This shows how to replace your existing API calls with mock calls

@riverpod
class MockUsageExample extends _$MockUsageExample {
  @override
  Future<Map<String, dynamic>> build() async {
    // Get the API client (mock or real based on configuration)
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      // Example: Get dashboard summary
      final response = await apiClient.getDashboardSummary();
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.body,
          'isMock': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to load dashboard data',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Example: Get admin users with pagination
  Future<Map<String, dynamic>> getAdmins({
    int page = 1,
    int perPage = 20,
  }) async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getAdmins(
        page: page,
        perPage: perPage,
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.body,
          'isMock': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to load admin users',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Example: Create a new admin user
  Future<Map<String, dynamic>> createAdmin({
    required String username,
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    List<String>? roles,
  }) async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.createAdmin(
        username: username,
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
        roles: roles,
      );
      
      if (response.statusCode == 201) {
        return {
          'success': true,
          'data': response.body,
          'isMock': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to create admin user',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Example: Get driver approvals
  Future<Map<String, dynamic>> getDriverApprovals({
    String status = 'PENDING',
    int page = 1,
    int perPage = 20,
  }) async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverApprovals(
        status: status,
        page: page,
        perPage: perPage,
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.body,
          'isMock': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to load driver approvals',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
  
  /// Example: Approve a driver
  Future<Map<String, dynamic>> approveDriver({
    required int driverId,
    String? message,
  }) async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateDriverApproval(
        driverId: driverId,
        status: 'APPROVED',
        message: message,
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': response.body,
          'isMock': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
        };
      } else {
        return {
          'success': false,
          'error': 'Failed to approve driver',
          'statusCode': response.statusCode,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }
}
