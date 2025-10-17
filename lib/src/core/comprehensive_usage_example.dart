import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'api_service_factory.dart';

part 'comprehensive_usage_example.g.dart';

/// Comprehensive example showing how to use ALL endpoints from the Swagger file
/// This demonstrates the complete mock API system with all 49+ endpoints

@riverpod
class ComprehensiveUsageExample extends _$ComprehensiveUsageExample {
  @override
  Future<Map<String, dynamic>> build() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    return {
      'isMockMode': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
      'message': 'Comprehensive Mock API System Ready',
      'totalEndpoints': 49,
    };
  }
  
  // ========================================
  // ADMIN ENDPOINTS EXAMPLES
  // ========================================
  
  /// Example: Get all admin users
  Future<Map<String, dynamic>> getAdminsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getAdmins(page: 1, perPage: 20);
      return _handleResponse(response, 'Admin users retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Create a new admin user
  Future<Map<String, dynamic>> createAdminExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.createAdmin(
        username: 'new_admin',
        email: 'newadmin@example.com',
        password: 'SecurePassword123',
        fullName: 'New Admin User',
        phoneNumber: '+1234567890',
        roles: ['admin', 'moderator'],
      );
      return _handleResponse(response, 'Admin user created');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update admin roles
  Future<Map<String, dynamic>> updateAdminRolesExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateAdminRoles(
        adminId: 1,
        roles: ['admin', 'moderator', 'user_manager'],
      );
      return _handleResponse(response, 'Admin roles updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get driver approval requests
  Future<Map<String, dynamic>> getDriverApprovalsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverApprovals(
        status: 'PENDING',
        page: 1,
        perPage: 20,
      );
      return _handleResponse(response, 'Driver approvals retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Approve a driver
  Future<Map<String, dynamic>> approveDriverExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateDriverApproval(
        driverId: 101,
        status: 'APPROVED',
        message: 'Driver approved after document verification',
      );
      return _handleResponse(response, 'Driver approved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get payment requests
  Future<Map<String, dynamic>> getPaymentRequestsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getPaymentRequests(
        status: 'PENDING',
        requestType: 'WITHDRAWAL',
        page: 1,
        perPage: 20,
      );
      return _handleResponse(response, 'Payment requests retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Approve a payment request
  Future<Map<String, dynamic>> approvePaymentRequestExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updatePaymentRequest(
        requestId: 1,
        status: 'APPROVED',
        message: 'Payment request approved',
      );
      return _handleResponse(response, 'Payment request approved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get vendor approval requests
  Future<Map<String, dynamic>> getVendorApprovalsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getVendorApprovals(
        status: 'PENDING',
        page: 1,
        perPage: 20,
      );
      return _handleResponse(response, 'Vendor approvals retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Approve a vendor
  Future<Map<String, dynamic>> approveVendorExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateVendorApproval(
        vendorId: 201,
        status: 'APPROVED',
        message: 'Vendor approved after document verification',
      );
      return _handleResponse(response, 'Vendor approved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get dashboard summary
  Future<Map<String, dynamic>> getDashboardSummaryExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDashboardSummary();
      return _handleResponse(response, 'Dashboard summary retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get financial analytics
  Future<Map<String, dynamic>> getFinancialAnalyticsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getFinancialAnalytics(
        dateFrom: '2023-11-01',
        dateTo: '2023-11-30',
      );
      return _handleResponse(response, 'Financial analytics retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get journey analytics
  Future<Map<String, dynamic>> getJourneyAnalyticsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getJourneyAnalytics(
        dateFrom: '2023-11-01',
        dateTo: '2023-11-30',
      );
      return _handleResponse(response, 'Journey analytics retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get all permissions
  Future<Map<String, dynamic>> getPermissionsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getPermissions();
      return _handleResponse(response, 'Permissions retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get all roles
  Future<Map<String, dynamic>> getRolesExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getRoles();
      return _handleResponse(response, 'Roles retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Create a new role
  Future<Map<String, dynamic>> createRoleExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.createRole(
        name: 'SUPPORT_AGENT',
        description: 'Customer support agent with limited permissions',
        permissions: ['VIEW_ANALYTICS'],
      );
      return _handleResponse(response, 'Role created');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update a role
  Future<Map<String, dynamic>> updateRoleExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateRole(
        roleId: 4,
        name: 'SUPPORT_AGENT',
        description: 'Updated customer support agent role',
        permissions: ['VIEW_ANALYTICS', 'MANAGE_USERS'],
      );
      return _handleResponse(response, 'Role updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Delete a role
  Future<Map<String, dynamic>> deleteRoleExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.deleteRole(roleId: 4);
      return _handleResponse(response, 'Role deleted');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get all users
  Future<Map<String, dynamic>> getUsersExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getUsers(
        page: 1,
        perPage: 20,
        userType: 'CLIENT',
        isActive: true,
        search: 'john',
      );
      return _handleResponse(response, 'Users retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get user details
  Future<Map<String, dynamic>> getUserDetailsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getUserDetails(userId: 42);
      return _handleResponse(response, 'User details retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update user status
  Future<Map<String, dynamic>> updateUserStatusExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateUserStatus(
        userId: 42,
        isActive: true,
      );
      return _handleResponse(response, 'User status updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  // ========================================
  // AUTHENTICATION ENDPOINTS EXAMPLES
  // ========================================
  
  /// Example: Get admin permissions
  Future<Map<String, dynamic>> getAdminPermissionsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getAdminPermissions();
      return _handleResponse(response, 'Admin permissions retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get driver approval status
  Future<Map<String, dynamic>> getDriverApprovalStatusExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverApprovalStatus();
      return _handleResponse(response, 'Driver approval status retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Create driver join request
  Future<Map<String, dynamic>> createDriverJoinRequestExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.createDriverJoinRequest(
        vendorId: 201,
        message: 'I would like to join your delivery fleet',
      );
      return _handleResponse(response, 'Driver join request created');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Login user
  Future<Map<String, dynamic>> loginExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.login(
        email: 'john.doe@example.com',
        password: 'SecurePassword123',
      );
      return _handleResponse(response, 'User logged in');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Logout user
  Future<Map<String, dynamic>> logoutExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.logout();
      return _handleResponse(response, 'User logged out');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Complete profile
  Future<Map<String, dynamic>> completeProfileExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.completeProfile(
        profileData: {
          'address': '123 Main Street, City, State 12345',
          'date_of_birth': '1990-05-15',
          'preferred_payment_method': 'CREDIT_CARD',
        },
      );
      return _handleResponse(response, 'Profile completed');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Resend verification code
  Future<Map<String, dynamic>> resendCodeExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.resendCode(userId: 123);
      return _handleResponse(response, 'Verification code resent');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Refresh token
  Future<Map<String, dynamic>> refreshTokenExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.refreshToken();
      return _handleResponse(response, 'Token refreshed');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Register user
  Future<Map<String, dynamic>> registerExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.register(
        username: 'johndoe',
        email: 'john.doe@example.com',
        password: 'SecurePassword123',
        phoneNumber: '+1234567890',
        userType: 'CLIENT',
        fullName: 'John Doe',
      );
      return _handleResponse(response, 'User registered');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Reset password
  Future<Map<String, dynamic>> resetPasswordExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.resetPassword(
        userId: 123,
        code: '12345',
        newPassword: 'NewSecurePassword123',
      );
      return _handleResponse(response, 'Password reset');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Request password reset
  Future<Map<String, dynamic>> requestPasswordResetExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.requestPasswordReset(
        email: 'john.doe@example.com',
      );
      return _handleResponse(response, 'Password reset requested');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get vendor approval status
  Future<Map<String, dynamic>> getVendorApprovalStatusExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getVendorApprovalStatus();
      return _handleResponse(response, 'Vendor approval status retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Verify phone number
  Future<Map<String, dynamic>> verifyPhoneExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.verifyPhone(
        userId: 123,
        code: '12345',
      );
      return _handleResponse(response, 'Phone number verified');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  // ========================================
  // CLIENT ENDPOINTS EXAMPLES
  // ========================================
  
  /// Example: Get all clients
  Future<Map<String, dynamic>> getClientsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getClients();
      return _handleResponse(response, 'Clients retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get client details
  Future<Map<String, dynamic>> getClientDetailsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getClientDetails(clientId: 42);
      return _handleResponse(response, 'Client details retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update client
  Future<Map<String, dynamic>> updateClientExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateClient(
        clientId: 42,
        clientData: {
          'address': '123 New Street, City, State 12345',
          'company_name': 'Updated Company Name',
          'contact_email': 'new.email@example.com',
          'phone_number': '555-123-4567',
        },
      );
      return _handleResponse(response, 'Client updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get client journeys
  Future<Map<String, dynamic>> getClientJourneysExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getClientJourneys(
        clientId: 42,
        page: 1,
        perPage: 20,
        status: 'COMPLETED',
      );
      return _handleResponse(response, 'Client journeys retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get client vendors
  Future<Map<String, dynamic>> getClientVendorsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getClientVendors(clientId: 42);
      return _handleResponse(response, 'Client vendors retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get client vendor details
  Future<Map<String, dynamic>> getClientVendorDetailsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getClientVendorDetails(
        clientId: 42,
        vendorId: 201,
      );
      return _handleResponse(response, 'Client vendor details retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  // ========================================
  // DRIVER ENDPOINTS EXAMPLES
  // ========================================
  
  /// Example: Get all drivers
  Future<Map<String, dynamic>> getDriversExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDrivers(
        page: 1,
        perPage: 20,
        status: 'ACTIVE',
        search: 'jane',
      );
      return _handleResponse(response, 'Drivers retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get driver join requests
  Future<Map<String, dynamic>> getDriverJoinRequestsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverJoinRequests(
        page: 1,
        perPage: 20,
        status: 'PENDING',
      );
      return _handleResponse(response, 'Driver join requests retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get driver details
  Future<Map<String, dynamic>> getDriverDetailsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverDetails(driverId: 101);
      return _handleResponse(response, 'Driver details retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update driver details
  Future<Map<String, dynamic>> updateDriverExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateDriver(
        driverId: 101,
        driverData: {
          'vehicle_make': 'Toyota',
          'vehicle_model': 'Camry',
          'vehicle_year': 2023,
          'vehicle_color': 'Blue',
          'vehicle_plate': 'NEW123',
        },
      );
      return _handleResponse(response, 'Driver updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update driver availability
  Future<Map<String, dynamic>> updateDriverAvailabilityExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateDriverAvailability(
        driverId: 101,
        isAvailable: true,
      );
      return _handleResponse(response, 'Driver availability updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get driver journeys
  Future<Map<String, dynamic>> getDriverJourneysExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverJourneys(
        driverId: 101,
        page: 1,
        perPage: 20,
        status: 'COMPLETED',
      );
      return _handleResponse(response, 'Driver journeys retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get driver payments
  Future<Map<String, dynamic>> getDriverPaymentsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverPayments(
        driverId: 101,
        page: 1,
        perPage: 20,
        status: 'COMPLETED',
      );
      return _handleResponse(response, 'Driver payments retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get driver resource requests
  Future<Map<String, dynamic>> getDriverResourceRequestsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getDriverResourceRequests(
        driverId: 101,
        page: 1,
        perPage: 20,
      );
      return _handleResponse(response, 'Driver resource requests retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  // ========================================
  // JOURNEY ENDPOINTS EXAMPLES
  // ========================================
  
  /// Example: Get all journeys
  Future<Map<String, dynamic>> getJourneysExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getJourneys(
        page: 1,
        perPage: 20,
        status: 'COMPLETED',
        search: 'john',
      );
      return _handleResponse(response, 'Journeys retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get journey details
  Future<Map<String, dynamic>> getJourneyDetailsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getJourneyDetails(journeyId: 1);
      return _handleResponse(response, 'Journey details retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update journey
  Future<Map<String, dynamic>> updateJourneyExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateJourney(
        journeyId: 1,
        journeyData: {
          'pickup_address': '123 Updated Street, City, State',
          'delivery_address': '456 Updated Avenue, City, State',
          'fare': 30.00,
        },
      );
      return _handleResponse(response, 'Journey updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Assign driver to journey
  Future<Map<String, dynamic>> assignDriverToJourneyExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.assignDriverToJourney(
        journeyId: 1,
        driverId: 101,
      );
      return _handleResponse(response, 'Driver assigned to journey');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Cancel journey
  Future<Map<String, dynamic>> cancelJourneyExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.cancelJourney(
        journeyId: 1,
        reason: 'Client requested cancellation',
      );
      return _handleResponse(response, 'Journey cancelled');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get journey payments
  Future<Map<String, dynamic>> getJourneyPaymentsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getJourneyPayments(journeyId: 1);
      return _handleResponse(response, 'Journey payments retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Update journey status
  Future<Map<String, dynamic>> updateJourneyStatusExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.updateJourneyStatus(
        journeyId: 1,
        status: 'IN_PROGRESS',
        notes: 'Driver is on the way to pickup location',
      );
      return _handleResponse(response, 'Journey status updated');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Get journey waybills
  Future<Map<String, dynamic>> getJourneyWaybillsExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getJourneyWaybills(journeyId: 1);
      return _handleResponse(response, 'Journey waybills retrieved');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  /// Example: Upload journey waybill
  Future<Map<String, dynamic>> uploadJourneyWaybillExample() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.uploadJourneyWaybill(
        journeyId: 1,
        filePath: '/path/to/waybill.pdf',
      );
      return _handleResponse(response, 'Journey waybill uploaded');
    } catch (e) {
      return _handleError(e);
    }
  }
  
  // ========================================
  // HELPER METHODS
  // ========================================
  
  Map<String, dynamic> _handleResponse(dynamic response, String message) {
    return {
      'success': true,
      'message': message,
      'statusCode': response.statusCode,
      'data': response.body,
      'isMock': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
    };
  }
  
  Map<String, dynamic> _handleError(dynamic error) {
    return {
      'success': false,
      'error': error.toString(),
      'isMock': ref.read(apiServiceFactoryProvider.notifier).isMockMode,
    };
  }
}
