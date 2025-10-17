import 'dart:convert';
import 'package:http/http.dart' as http;
import 'mock_api_service.dart';

/// Mock API Client that implements the same interface as your real API client
/// but returns mock responses loaded from JSON files
class MockApiClient {
  static const String baseUrl = 'https://api.revoltrans.com';
  
  /// Check if mock mode is enabled
  static bool get isMockMode => MockApiService.isMockMode;
  
  /// GET request
  Future<http.Response> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    List<String> requiredQueryParams = const [],
  }) async {
    if (!isMockMode) {
      throw Exception('Mock API client called but mock mode is disabled');
    }
    
    return await MockApiService.get(
      endpoint,
      queryParams: queryParams,
      headers: headers,
      requiredQueryParams: requiredQueryParams,
    );
  }
  
  /// POST request
  Future<http.Response> post(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    List<String> requiredBodyFields = const [],
  }) async {
    if (!isMockMode) {
      throw Exception('Mock API client called but mock mode is disabled');
    }
    
    return await MockApiService.post(
      endpoint,
      body: body,
      headers: headers,
      requiredBodyFields: requiredBodyFields,
    );
  }
  
  /// PUT request
  Future<http.Response> put(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    List<String> requiredBodyFields = const [],
  }) async {
    if (!isMockMode) {
      throw Exception('Mock API client called but mock mode is disabled');
    }
    
    return await MockApiService.put(
      endpoint,
      body: body,
      headers: headers,
      requiredBodyFields: requiredBodyFields,
    );
  }
  
  /// DELETE request
  Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    if (!isMockMode) {
      throw Exception('Mock API client called but mock mode is disabled');
    }
    
    return await MockApiService.delete(
      endpoint,
      headers: headers,
    );
  }
  
  // ========================================
  // ADMIN ENDPOINTS
  // ========================================
  
  /// Get all admin users
  Future<http.Response> getAdmins({
    int page = 1,
    int perPage = 20,
  }) async {
    return await get(
      '/api/v1/admin/admins',
      queryParams: {
        'page': page,
        'per_page': perPage,
      },
    );
  }
  
  /// Create a new admin user
  Future<http.Response> createAdmin({
    required String username,
    required String email,
    required String password,
    required String fullName,
    String? phoneNumber,
    List<String>? roles,
  }) async {
    return await post(
      '/api/v1/admin/admins',
      body: {
        'username': username,
        'email': email,
        'password': password,
        'full_name': fullName,
        if (phoneNumber != null) 'phone_number': phoneNumber,
        if (roles != null) 'roles': roles,
      },
      requiredBodyFields: ['username', 'email', 'password', 'full_name'],
    );
  }
  
  /// Update admin roles
  Future<http.Response> updateAdminRoles({
    required int adminId,
    required List<String> roles,
  }) async {
    return await put(
      '/api/v1/admin/admins/$adminId/roles',
      body: {
        'roles': roles,
      },
      requiredBodyFields: ['roles'],
    );
  }
  
  /// Get driver approval requests
  Future<http.Response> getDriverApprovals({
    String status = 'PENDING',
    int page = 1,
    int perPage = 20,
  }) async {
    return await get(
      '/api/v1/admin/approvals/drivers',
      queryParams: {
        'status': status,
        'page': page,
        'per_page': perPage,
      },
    );
  }
  
  /// Approve or reject a driver
  Future<http.Response> updateDriverApproval({
    required int driverId,
    required String status,
    String? message,
  }) async {
    return await put(
      '/api/v1/admin/approvals/drivers/$driverId',
      body: {
        'status': status,
        if (message != null) 'message': message,
      },
      requiredBodyFields: ['status'],
    );
  }
  
  /// Get payment requests
  Future<http.Response> getPaymentRequests({
    String status = 'PENDING',
    String? requestType,
    int page = 1,
    int perPage = 20,
  }) async {
    return await get(
      '/api/v1/admin/approvals/payment-requests',
      queryParams: {
        'status': status,
        if (requestType != null) 'request_type': requestType,
        'page': page,
        'per_page': perPage,
      },
    );
  }
  
  /// Approve or reject a payment request
  Future<http.Response> updatePaymentRequest({
    required int requestId,
    required String status,
    String? message,
  }) async {
    return await put(
      '/api/v1/admin/approvals/payment-requests/$requestId',
      body: {
        'status': status,
        if (message != null) 'message': message,
      },
      requiredBodyFields: ['status'],
    );
  }
  
  /// Get vendor approval requests
  Future<http.Response> getVendorApprovals({
    String status = 'PENDING',
    int page = 1,
    int perPage = 20,
  }) async {
    return await get(
      '/api/v1/admin/approvals/vendors',
      queryParams: {
        'status': status,
        'page': page,
        'per_page': perPage,
      },
    );
  }
  
  /// Approve or reject a vendor
  Future<http.Response> updateVendorApproval({
    required int vendorId,
    required String status,
    String? message,
  }) async {
    return await put(
      '/api/v1/admin/approvals/vendors/$vendorId',
      body: {
        'status': status,
        if (message != null) 'message': message,
      },
      requiredBodyFields: ['status'],
    );
  }
  
  /// Get dashboard summary
  Future<http.Response> getDashboardSummary() async {
    return await get('/api/v1/admin/dashboard/summary');
  }
  
  /// Get financial analytics
  Future<http.Response> getFinancialAnalytics({
    String? dateFrom,
    String? dateTo,
  }) async {
    return await get(
      '/api/v1/admin/dashboard/financial',
      queryParams: {
        if (dateFrom != null) 'date_from': dateFrom,
        if (dateTo != null) 'date_to': dateTo,
      },
    );
  }
  
  /// Get journey analytics
  Future<http.Response> getJourneyAnalytics({
    String? dateFrom,
    String? dateTo,
  }) async {
    return await get(
      '/api/v1/admin/dashboard/journeys',
      queryParams: {
        if (dateFrom != null) 'date_from': dateFrom,
        if (dateTo != null) 'date_to': dateTo,
      },
    );
  }
  
  /// Get all permissions
  Future<http.Response> getPermissions() async {
    return await get('/api/v1/admin/permissions');
  }
  
  /// Get all roles
  Future<http.Response> getRoles() async {
    return await get('/api/v1/admin/roles');
  }
  
  /// Create a new role
  Future<http.Response> createRole({
    required String name,
    String? description,
    List<String>? permissions,
  }) async {
    return await post(
      '/api/v1/admin/roles',
      body: {
        'name': name,
        if (description != null) 'description': description,
        if (permissions != null) 'permissions': permissions,
      },
      requiredBodyFields: ['name'],
    );
  }
  
  /// Update a role
  Future<http.Response> updateRole({
    required int roleId,
    String? name,
    String? description,
    List<String>? permissions,
  }) async {
    return await put(
      '/api/v1/admin/roles/$roleId',
      body: {
        if (name != null) 'name': name,
        if (description != null) 'description': description,
        if (permissions != null) 'permissions': permissions,
      },
    );
  }
  
  /// Delete a role
  Future<http.Response> deleteRole({
    required int roleId,
  }) async {
    return await delete('/api/v1/admin/roles/$roleId');
  }
  
  /// Get all users
  Future<http.Response> getUsers({
    int page = 1,
    int perPage = 20,
    String? userType,
    bool? isActive,
    String? search,
  }) async {
    return await get(
      '/api/v1/admin/users',
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (userType != null) 'user_type': userType,
        if (isActive != null) 'is_active': isActive,
        if (search != null) 'search': search,
      },
    );
  }
}
