import 'dart:convert';
import 'package:http/http.dart' as http;
import 'mock_api_service.dart';

/// Comprehensive Mock API Client that implements ALL endpoints from the Swagger file
/// This replaces the basic mock_api_client.dart with complete coverage
class ComprehensiveMockApiClient {
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
  
  /// PATCH request
  Future<http.Response> patch(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    List<String> requiredBodyFields = const [],
  }) async {
    if (!isMockMode) {
      throw Exception('Mock API client called but mock mode is disabled');
    }
    
    return await MockApiService.put( // Using PUT for PATCH in mock
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
  
  /// Get user details
  Future<http.Response> getUserDetails({
    required int userId,
  }) async {
    return await get('/api/v1/admin/users/$userId');
  }
  
  /// Update user status
  Future<http.Response> updateUserStatus({
    required int userId,
    required bool isActive,
  }) async {
    return await patch(
      '/api/v1/admin/users/$userId/status',
      body: {
        'is_active': isActive,
      },
      requiredBodyFields: ['is_active'],
    );
  }
  
  // ========================================
  // AUTHENTICATION ENDPOINTS
  // ========================================
  
  /// Get admin permissions
  Future<http.Response> getAdminPermissions() async {
    return await get('/api/v1/auth/admin/permissions');
  }
  
  /// Get driver approval status
  Future<http.Response> getDriverApprovalStatus() async {
    return await get('/api/v1/auth/driver-approval-status');
  }
  
  /// Create driver join request
  Future<http.Response> createDriverJoinRequest({
    required int vendorId,
    String? message,
  }) async {
    return await post(
      '/api/v1/auth/driver/join-request',
      body: {
        'vendor_id': vendorId,
        if (message != null) 'message': message,
      },
      requiredBodyFields: ['vendor_id'],
    );
  }
  
  /// Login user
  Future<http.Response> login({
    String? username,
    String? email,
    required String password,
  }) async {
    print('Hereeeeeeee');
    return await post(
      '/api/v1/auth/login',
      body: {
        'email': email,
        'password': password,
      },
      requiredBodyFields: ['password'],
    );
  }
  
  /// Logout user
  Future<http.Response> logout() async {
    return await post('/api/v1/auth/logout');
  }
  
  /// Complete profile
  Future<http.Response> completeProfile({
    required Map<String, dynamic> profileData,
  }) async {
    return await post(
      '/api/v1/auth/profile-completion',
      body: profileData,
    );
  }
  
  /// Resend verification code
  Future<http.Response> resendCode({
    required int userId,
  }) async {
    return await post(
      '/api/v1/auth/re-send-code',
      body: {
        'user_id': userId,
      },
      requiredBodyFields: ['user_id'],
    );
  }
  
  /// Refresh token
  Future<http.Response> refreshToken() async {
    return await post('/api/v1/auth/refresh');
  }
  
  /// Register user
  Future<http.Response> register({
    required String username,
    required String email,
    required String password,
    required String phoneNumber,
    required String userType,
    String? fullName,
  }) async {
    return await post(
      '/api/v1/auth/register',
      body: {
        'username': username,
        'email': email,
        'password': password,
        'phone_number': phoneNumber,
        'user_type': userType,
        if (fullName != null) 'full_name': fullName,
      },
      requiredBodyFields: ['username', 'email', 'password', 'phone_number', 'user_type'],
    );
  }
  
  /// Reset password
  Future<http.Response> resetPassword({
    required int userId,
    required String code,
    required String newPassword,
  }) async {
    return await post(
      '/api/v1/auth/reset-password',
      body: {
        'user_id': userId,
        'code': code,
        'new_password': newPassword,
      },
      requiredBodyFields: ['user_id', 'code', 'new_password'],
    );
  }
  
  /// Request password reset
  Future<http.Response> requestPasswordReset({
    required String email,
  }) async {
    return await post(
      '/api/v1/auth/reset-password-request',
      body: {
        'email': email,
      },
      requiredBodyFields: ['email'],
    );
  }
  
  /// Get vendor approval status
  Future<http.Response> getVendorApprovalStatus() async {
    return await get('/api/v1/auth/vendor-approval-status');
  }
  
  /// Verify phone number
  Future<http.Response> verifyPhone({
    required int userId,
    required String code,
  }) async {
    return await post(
      '/api/v1/auth/verify',
      body: {
        'user_id': userId,
        'code': code,
      },
      requiredBodyFields: ['user_id', 'code'],
    );
  }
  
  // ========================================
  // CLIENT ENDPOINTS
  // ========================================
  
  /// Get all clients
  Future<http.Response> getClients() async {
    return await get('/api/v1/clients/');
  }
  
  /// Get client details
  Future<http.Response> getClientDetails({
    required int clientId,
  }) async {
    return await get('/api/v1/clients/$clientId');
  }
  
  /// Update client
  Future<http.Response> updateClient({
    required int clientId,
    required Map<String, dynamic> clientData,
  }) async {
    return await put(
      '/api/v1/clients/$clientId',
      body: clientData,
    );
  }
  
  /// Get client journeys
  Future<http.Response> getClientJourneys({
    required int clientId,
    int page = 1,
    int perPage = 20,
    String? status,
  }) async {
    return await get(
      '/api/v1/clients/$clientId/journeys',
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (status != null) 'status': status,
      },
    );
  }
  
  /// Get client vendors
  Future<http.Response> getClientVendors({
    required int clientId,
  }) async {
    return await get('/api/v1/clients/$clientId/vendors');
  }
  
  /// Get client vendor details
  Future<http.Response> getClientVendorDetails({
    required int clientId,
    required int vendorId,
  }) async {
    return await get('/api/v1/clients/$clientId/vendors/$vendorId');
  }
  
  // ========================================
  // DRIVER ENDPOINTS
  // ========================================
  
  /// Get all drivers
  Future<http.Response> getDrivers({
    int page = 1,
    int perPage = 20,
    String? status,
    String? search,
  }) async {
    return await get(
      '/api/v1/drivers/',
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (status != null) 'status': status,
        if (search != null) 'search': search,
      },
    );
  }
  
  /// Get driver join requests
  Future<http.Response> getDriverJoinRequests({
    int page = 1,
    int perPage = 20,
    String? status,
  }) async {
    return await get(
      '/api/v1/drivers/join-requests',
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (status != null) 'status': status,
      },
    );
  }
  
  /// Get driver details
  Future<http.Response> getDriverDetails({
    required int driverId,
  }) async {
    return await get('/api/v1/drivers/$driverId');
  }
  
  /// Update driver details
  Future<http.Response> updateDriver({
    required int driverId,
    required Map<String, dynamic> driverData,
  }) async {
    return await put(
      '/api/v1/drivers/$driverId',
      body: driverData,
    );
  }
  
  /// Update driver availability
  Future<http.Response> updateDriverAvailability({
    required int driverId,
    required bool isAvailable,
  }) async {
    return await put(
      '/api/v1/drivers/$driverId/availability',
      body: {
        'is_available': isAvailable,
      },
      requiredBodyFields: ['is_available'],
    );
  }
  
  /// Get driver journeys
  Future<http.Response> getDriverJourneys({
    required int driverId,
    int page = 1,
    int perPage = 20,
    String? status,
  }) async {
    return await get(
      '/api/v1/drivers/$driverId/journeys',
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (status != null) 'status': status,
      },
    );
  }
  
  /// Get driver payments
  Future<http.Response> getDriverPayments({
    required int driverId,
    int page = 1,
    int perPage = 20,
    String? status,
  }) async {
    return await get(
      '/api/v1/drivers/$driverId/payments',
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (status != null) 'status': status,
      },
    );
  }
  
  /// Get driver resource requests
  Future<http.Response> getDriverResourceRequests({
    required int driverId,
    int page = 1,
    int perPage = 20,
  }) async {
    return await get(
      '/api/v1/drivers/$driverId/resource-requests',
      queryParams: {
        'page': page,
        'per_page': perPage,
      },
    );
  }
  
  // ========================================
  // JOURNEY ENDPOINTS
  // ========================================
  
  /// Get all journeys
  Future<http.Response> getJourneys({
    int page = 1,
    int perPage = 20,
    String? status,
    String? search,
  }) async {
    return await get(
      '/api/v1/journeys/',
      queryParams: {
        'page': page,
        'per_page': perPage,
        if (status != null) 'status': status,
        if (search != null) 'search': search,
      },
    );
  }
  
  /// Get journey details
  Future<http.Response> getJourneyDetails({
    required int journeyId,
  }) async {
    return await get('/api/v1/journeys/$journeyId');
  }
  
  /// Update journey
  Future<http.Response> updateJourney({
    required int journeyId,
    required Map<String, dynamic> journeyData,
  }) async {
    return await put(
      '/api/v1/journeys/$journeyId',
      body: journeyData,
    );
  }
  
  /// Assign driver to journey
  Future<http.Response> assignDriverToJourney({
    required int journeyId,
    required int driverId,
  }) async {
    return await post(
      '/api/v1/journeys/$journeyId/assign-driver',
      body: {
        'driver_id': driverId,
      },
      requiredBodyFields: ['driver_id'],
    );
  }
  
  /// Cancel journey
  Future<http.Response> cancelJourney({
    required int journeyId,
    String? reason,
  }) async {
    return await post(
      '/api/v1/journeys/$journeyId/cancel',
      body: {
        if (reason != null) 'reason': reason,
      },
    );
  }
  
  /// Get journey payments
  Future<http.Response> getJourneyPayments({
    required int journeyId,
  }) async {
    return await get('/api/v1/journeys/$journeyId/payments');
  }
  
  /// Update journey status
  Future<http.Response> updateJourneyStatus({
    required int journeyId,
    required String status,
    String? notes,
  }) async {
    return await put(
      '/api/v1/journeys/$journeyId/status',
      body: {
        'status': status,
        if (notes != null) 'notes': notes,
      },
      requiredBodyFields: ['status'],
    );
  }
  
  /// Get journey waybills
  Future<http.Response> getJourneyWaybills({
    required int journeyId,
  }) async {
    return await get('/api/v1/journeys/$journeyId/waybills');
  }
  
  /// Upload journey waybill
  Future<http.Response> uploadJourneyWaybill({
    required int journeyId,
    required String filePath,
  }) async {
    return await post(
      '/api/v1/journeys/$journeyId/waybills',
      body: {
        'file_path': filePath,
      },
      requiredBodyFields: ['file_path'],
    );
  }
}
