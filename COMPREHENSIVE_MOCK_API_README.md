# Comprehensive Mock API System for Revoltrans App

This document provides complete documentation for the comprehensive mock API system that covers **ALL 49+ endpoints** from your Swagger specification.

## 🎯 **Complete Coverage**

✅ **49+ Endpoints** - Every endpoint from your Swagger file  
✅ **Parameter Validation** - All required parameters validated  
✅ **JSON Mock Responses** - Realistic mock data for every endpoint  
✅ **Error Handling** - Proper HTTP status codes and error messages  
✅ **Easy Integration** - Drop-in replacement for your real API  

## 📁 **File Structure**

```
lib/src/core/
├── comprehensive_mock_api_client.dart    # Complete API client with all endpoints
├── mock_api_service.dart                 # Core mock service logic
├── api_service_factory.dart              # Factory to switch between mock/real APIs
└── comprehensive_usage_example.dart      # Complete usage examples

assets/mocks/api/
├── admin_admins_get.json                 # Admin management endpoints
├── admin_admins_post.json
├── admin_admins_{admin_id}_roles_put.json
├── admin_approvals_drivers_get.json      # Driver approval endpoints
├── admin_approvals_drivers_{driver_id}_put.json
├── admin_approvals_payment-requests_get.json
├── admin_approvals_payment-requests_{request_id}_put.json
├── admin_approvals_vendors_get.json
├── admin_approvals_vendors_{vendor_id}_put.json
├── admin_dashboard_summary_get.json      # Dashboard endpoints
├── admin_dashboard_financial_get.json
├── admin_dashboard_journeys_get.json
├── admin_permissions_get.json            # Permission & role endpoints
├── admin_roles_get.json
├── admin_roles_post.json
├── admin_roles_{role_id}_put.json
├── admin_roles_{role_id}_delete.json
├── admin_users_get.json                  # User management endpoints
├── admin_users_{user_id}_get.json
├── admin_users_{user_id}_status_patch.json
├── auth_admin_permissions_get.json       # Authentication endpoints
├── auth_driver-approval-status_get.json
├── auth_driver_join-request_post.json
├── auth_login_post.json
├── auth_logout_post.json
├── auth_profile-completion_post.json
├── auth_re-send-code_post.json
├── auth_refresh_post.json
├── auth_register_post.json
├── auth_reset-password_post.json
├── auth_reset-password-request_post.json
├── auth_vendor-approval-status_get.json
├── auth_verify_post.json
├── clients__get.json                     # Client endpoints
├── clients_{client_id}_get.json
├── clients_{client_id}_put.json
├── clients_{client_id}_journeys_get.json
├── clients_{client_id}_vendors_get.json
├── clients_{client_id}_vendors_{vendor_id}_get.json
├── drivers__get.json                     # Driver endpoints
├── drivers_join-requests_get.json
├── drivers_{driver_id}_get.json
├── drivers_{driver_id}_put.json
├── drivers_{driver_id}_availability_put.json
├── drivers_{driver_id}_journeys_get.json
├── drivers_{driver_id}_payments_get.json
├── drivers_{driver_id}_resource-requests_get.json
├── journeys__get.json                    # Journey endpoints
├── journeys_{journey_id}_get.json
├── journeys_{journey_id}_put.json
├── journeys_{journey_id}_assign-driver_post.json
├── journeys_{journey_id}_cancel_post.json
├── journeys_{journey_id}_payments_get.json
├── journeys_{journey_id}_status_put.json
├── journeys_{journey_id}_waybills_get.json
└── journeys_{journey_id}_waybills_post.json
```

## 🚀 **Quick Start**

### 1. Enable Mock Mode
```bash
flutter run --dart-define=MOCK_API=true
```

### 2. Use in Your Controllers
```dart
// Get the API client
final apiClient = ref.read(apiServiceFactoryProvider);

// Use any endpoint
final response = await apiClient.getDashboardSummary();
final response = await apiClient.getAdmins(page: 1, perPage: 20);
final response = await apiClient.login(email: 'user@example.com', password: 'password');
```

## 📋 **Complete Endpoint Reference**

### **Admin Endpoints (17 endpoints)**

| Method | Endpoint | Description | Required Parameters |
|--------|----------|-------------|-------------------|
| GET | `/api/v1/admin/admins` | Get all admin users | `page`, `per_page` |
| POST | `/api/v1/admin/admins` | Create admin user | `username`, `email`, `password`, `full_name` |
| PUT | `/api/v1/admin/admins/{admin_id}/roles` | Update admin roles | `roles` |
| GET | `/api/v1/admin/approvals/drivers` | Get driver approvals | `status`, `page`, `per_page` |
| PUT | `/api/v1/admin/approvals/drivers/{driver_id}` | Update driver approval | `status` |
| GET | `/api/v1/admin/approvals/payment-requests` | Get payment requests | `status`, `page`, `per_page` |
| PUT | `/api/v1/admin/approvals/payment-requests/{request_id}` | Update payment request | `status` |
| GET | `/api/v1/admin/approvals/vendors` | Get vendor approvals | `status`, `page`, `per_page` |
| PUT | `/api/v1/admin/approvals/vendors/{vendor_id}` | Update vendor approval | `status` |
| GET | `/api/v1/admin/dashboard/summary` | Get dashboard summary | - |
| GET | `/api/v1/admin/dashboard/financial` | Get financial analytics | `date_from`, `date_to` |
| GET | `/api/v1/admin/dashboard/journeys` | Get journey analytics | `date_from`, `date_to` |
| GET | `/api/v1/admin/permissions` | Get all permissions | - |
| GET | `/api/v1/admin/roles` | Get all roles | - |
| POST | `/api/v1/admin/roles` | Create role | `name` |
| PUT | `/api/v1/admin/roles/{role_id}` | Update role | - |
| DELETE | `/api/v1/admin/roles/{role_id}` | Delete role | - |
| GET | `/api/v1/admin/users` | Get all users | `page`, `per_page` |
| GET | `/api/v1/admin/users/{user_id}` | Get user details | - |
| PATCH | `/api/v1/admin/users/{user_id}/status` | Update user status | `is_active` |

### **Authentication Endpoints (12 endpoints)**

| Method | Endpoint | Description | Required Parameters |
|--------|----------|-------------|-------------------|
| GET | `/api/v1/auth/admin/permissions` | Get admin permissions | - |
| GET | `/api/v1/auth/driver-approval-status` | Get driver approval status | - |
| POST | `/api/v1/auth/driver/join-request` | Create driver join request | `vendor_id` |
| POST | `/api/v1/auth/login` | Login user | `password` + (`username` OR `email`) |
| POST | `/api/v1/auth/logout` | Logout user | - |
| POST | `/api/v1/auth/profile-completion` | Complete profile | Profile data based on user type |
| POST | `/api/v1/auth/re-send-code` | Resend verification code | `user_id` |
| POST | `/api/v1/auth/refresh` | Refresh token | - |
| POST | `/api/v1/auth/register` | Register user | `username`, `email`, `password`, `phone_number`, `user_type` |
| POST | `/api/v1/auth/reset-password` | Reset password | `user_id`, `code`, `new_password` |
| POST | `/api/v1/auth/reset-password-request` | Request password reset | `email` |
| GET | `/api/v1/auth/vendor-approval-status` | Get vendor approval status | - |
| POST | `/api/v1/auth/verify` | Verify phone number | `user_id`, `code` |

### **Client Endpoints (6 endpoints)**

| Method | Endpoint | Description | Required Parameters |
|--------|----------|-------------|-------------------|
| GET | `/api/v1/clients/` | Get all clients | - |
| GET | `/api/v1/clients/{client_id}` | Get client details | - |
| PUT | `/api/v1/clients/{client_id}` | Update client | Client data |
| GET | `/api/v1/clients/{client_id}/journeys` | Get client journeys | `page`, `per_page` |
| GET | `/api/v1/clients/{client_id}/vendors` | Get client vendors | - |
| GET | `/api/v1/clients/{client_id}/vendors/{vendor_id}` | Get client vendor details | - |

### **Driver Endpoints (8 endpoints)**

| Method | Endpoint | Description | Required Parameters |
|--------|----------|-------------|-------------------|
| GET | `/api/v1/drivers/` | Get all drivers | `page`, `per_page` |
| GET | `/api/v1/drivers/join-requests` | Get driver join requests | `page`, `per_page` |
| GET | `/api/v1/drivers/{driver_id}` | Get driver details | - |
| PUT | `/api/v1/drivers/{driver_id}` | Update driver | Driver data |
| PUT | `/api/v1/drivers/{driver_id}/availability` | Update driver availability | `is_available` |
| GET | `/api/v1/drivers/{driver_id}/journeys` | Get driver journeys | `page`, `per_page` |
| GET | `/api/v1/drivers/{driver_id}/payments` | Get driver payments | `page`, `per_page` |
| GET | `/api/v1/drivers/{driver_id}/resource-requests` | Get driver resource requests | `page`, `per_page` |

### **Journey Endpoints (8 endpoints)**

| Method | Endpoint | Description | Required Parameters |
|--------|----------|-------------|-------------------|
| GET | `/api/v1/journeys/` | Get all journeys | `page`, `per_page` |
| GET | `/api/v1/journeys/{journey_id}` | Get journey details | - |
| PUT | `/api/v1/journeys/{journey_id}` | Update journey | Journey data |
| POST | `/api/v1/journeys/{journey_id}/assign-driver` | Assign driver to journey | `driver_id` |
| POST | `/api/v1/journeys/{journey_id}/cancel` | Cancel journey | - |
| GET | `/api/v1/journeys/{journey_id}/payments` | Get journey payments | - |
| PUT | `/api/v1/journeys/{journey_id}/status` | Update journey status | `status` |
| GET | `/api/v1/journeys/{journey_id}/waybills` | Get journey waybills | - |
| POST | `/api/v1/journeys/{journey_id}/waybills` | Upload journey waybill | `file_path` |

## 💡 **Usage Examples**

### **Admin Management**
```dart
// Get all admin users
final response = await apiClient.getAdmins(page: 1, perPage: 20);

// Create new admin
final response = await apiClient.createAdmin(
  username: 'new_admin',
  email: 'admin@example.com',
  password: 'SecurePassword123',
  fullName: 'New Admin User',
  roles: ['admin', 'moderator'],
);

// Update admin roles
final response = await apiClient.updateAdminRoles(
  adminId: 1,
  roles: ['admin', 'moderator', 'user_manager'],
);
```

### **Authentication**
```dart
// Login user
final response = await apiClient.login(
  email: 'user@example.com',
  password: 'SecurePassword123',
);

// Register new user
final response = await apiClient.register(
  username: 'johndoe',
  email: 'john@example.com',
  password: 'SecurePassword123',
  phoneNumber: '+1234567890',
  userType: 'CLIENT',
  fullName: 'John Doe',
);

// Complete profile
final response = await apiClient.completeProfile(
  profileData: {
    'address': '123 Main Street, City, State',
    'date_of_birth': '1990-05-15',
    'preferred_payment_method': 'CREDIT_CARD',
  },
);
```

### **Driver Management**
```dart
// Get all drivers
final response = await apiClient.getDrivers(
  page: 1,
  perPage: 20,
  status: 'ACTIVE',
  search: 'jane',
);

// Update driver availability
final response = await apiClient.updateDriverAvailability(
  driverId: 101,
  isAvailable: true,
);

// Get driver payments
final response = await apiClient.getDriverPayments(
  driverId: 101,
  page: 1,
  perPage: 20,
  status: 'COMPLETED',
);
```

### **Journey Management**
```dart
// Get all journeys
final response = await apiClient.getJourneys(
  page: 1,
  perPage: 20,
  status: 'COMPLETED',
  search: 'john',
);

// Assign driver to journey
final response = await apiClient.assignDriverToJourney(
  journeyId: 1,
  driverId: 101,
);

// Update journey status
final response = await apiClient.updateJourneyStatus(
  journeyId: 1,
  status: 'IN_PROGRESS',
  notes: 'Driver is on the way to pickup location',
);
```

## 🔧 **Configuration**

### **Environment Variables**
```bash
# Enable mock mode (default)
flutter run --dart-define=MOCK_API=true

# Disable mock mode (use real API)
flutter run --dart-define=MOCK_API=false
```

### **Code Configuration**
```dart
// Switch to mock mode programmatically
ref.read(apiServiceFactoryProvider.notifier).switchToMock();

// Switch to real mode (when implemented)
ref.read(apiServiceFactoryProvider.notifier).switchToReal();
```

## 📊 **Mock Data Features**

### **Realistic Data**
- **Users**: Complete user profiles with contact information
- **Drivers**: Vehicle details, ratings, earnings, availability
- **Vendors**: Business information, ratings, cuisine types
- **Journeys**: Pickup/delivery addresses, fares, status tracking
- **Payments**: Transaction details, payment methods, status
- **Analytics**: Dashboard summaries, financial reports, journey statistics

### **Parameter Validation**
- **Query Parameters**: Validated for pagination, filtering, search
- **Body Parameters**: Required fields checked before response
- **Path Parameters**: ID validation for resource endpoints
- **Error Responses**: 400 Bad Request for missing required parameters

### **HTTP Status Codes**
- **200**: Success responses
- **201**: Created responses (POST endpoints)
- **400**: Bad Request (missing required parameters)
- **401**: Unauthorized (authentication required)
- **403**: Forbidden (insufficient permissions)
- **404**: Not Found (resource not found)
- **500**: Internal Server Error (mock service errors)

## 🚀 **Benefits**

1. **Complete Coverage**: All 49+ endpoints from your Swagger file
2. **Fast Development**: No backend dependency during development
3. **Consistent Testing**: Same mock data every time
4. **Parameter Validation**: Catches missing parameters early
5. **Easy Integration**: Drop-in replacement for real API
6. **Realistic Data**: Comprehensive mock responses with proper structure
7. **Error Scenarios**: Test error handling with proper HTTP status codes

## 🔄 **Migration to Real API**

When you're ready to use the real API:

1. **Implement Real API Client**: Create your real API client
2. **Update Factory**: Replace `ComprehensiveMockApiClient` with real client
3. **Environment Switch**: Use `--dart-define=MOCK_API=false`
4. **No Code Changes**: All your existing code continues to work

## 📝 **Adding New Endpoints**

1. **Add Method**: Add new method to `ComprehensiveMockApiClient`
2. **Create JSON**: Add mock response JSON file
3. **Update Examples**: Add usage example to `ComprehensiveUsageExample`
4. **Test**: Verify parameter validation works correctly

## 🆘 **Troubleshooting**

### **Mock Response Not Found**
- Check file naming convention: `{endpoint}_{method}.json`
- Ensure file is in `assets/mocks/api/` directory
- Verify `pubspec.yaml` includes the assets directory

### **Parameter Validation Errors**
- Check that all required parameters are provided
- Verify parameter names match the API specification
- Check the `requiredQueryParams` and `requiredBodyFields` arrays

### **Build Errors**
- Run `flutter packages get` after adding new assets
- Run `dart run build_runner build` if using code generation
- Check that all imports are correct

## 🎉 **Ready to Use!**

Your comprehensive mock API system is now ready with:
- ✅ **49+ endpoints** fully implemented
- ✅ **Parameter validation** for all endpoints
- ✅ **Realistic mock data** for every response
- ✅ **Complete documentation** and examples
- ✅ **Easy integration** with your existing code

Start developing with confidence knowing you have a complete mock API system that covers every endpoint in your Swagger specification!
