# Mock API System for Revoltrans App

This document explains how to use the mock API system for local development and testing.

## Overview

The mock API system allows you to:
- Test your app without making real API calls
- Validate required parameters before returning responses
- Load mock responses from local JSON files
- Switch between mock and real APIs easily

## Files Structure

```
lib/src/core/
├── mock_api_service.dart      # Core mock service logic
├── mock_api_client.dart       # Mock API client with all endpoints
├── api_service_factory.dart   # Factory to switch between mock/real APIs
└── mock_usage_example.dart    # Example usage

assets/mocks/api/
├── admin_admins_get.json
├── admin_admins_post.json
├── admin_dashboard_summary_get.json
└── ... (more mock response files)
```

## How to Use

### 1. Enable/Disable Mock Mode

**Option A: Environment Variable (Recommended)**
```bash
# Enable mock mode (default)
flutter run --dart-define=MOCK_API=true

# Disable mock mode (use real API)
flutter run --dart-define=MOCK_API=false
```

**Option B: Code Configuration**
```dart
// In your main.dart or app initialization
const bool mockMode = bool.fromEnvironment('MOCK_API', defaultValue: true);
```

### 2. Using the Mock API in Your Controllers

Replace your existing API calls with the mock API client:

```dart
// Before (using real API)
final response = await http.get(Uri.parse('$baseUrl/api/v1/admin/dashboard/summary'));

// After (using mock API)
final apiClient = ref.read(apiServiceFactoryProvider);
final response = await apiClient.getDashboardSummary();
```

### 3. Example Controller Integration

```dart
@riverpod
class AdminController extends _$AdminController {
  @override
  Future<List<Admin>> build() async {
    final apiClient = ref.read(apiServiceFactoryProvider);
    
    try {
      final response = await apiClient.getAdmins(page: 1, perPage: 20);
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data['items'] as List)
            .map((item) => Admin.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load admins');
      }
    } catch (e) {
      throw Exception('API Error: $e');
    }
  }
}
```

## Mock Response Files

### File Naming Convention

Mock response files follow this pattern:
```
{endpoint}_{method}.json
```

Examples:
- `/api/v1/admin/admins` GET → `admin_admins_get.json`
- `/api/v1/admin/admins` POST → `admin_admins_post.json`
- `/api/v1/admin/admins/{admin_id}/roles` PUT → `admin_admins_{admin_id}_roles_put.json`

### File Structure

Each mock response file should contain:
```json
{
  "statusCode": 200,
  "data": {
    // Your mock response data here
  }
}
```

### Example Mock Response

```json
{
  "statusCode": 200,
  "items": [
    {
      "id": 1,
      "username": "admin_user",
      "email": "admin@example.com",
      "full_name": "John Admin",
      "roles": ["admin"],
      "is_active": true
    }
  ],
  "pagination": {
    "page": 1,
    "per_page": 20,
    "total": 1,
    "pages": 1
  }
}
```

## Parameter Validation

The mock API automatically validates required parameters:

### Query Parameters
```dart
// This will return 400 error if 'page' is missing
final response = await apiClient.getAdmins(page: 1, perPage: 20);
```

### Body Parameters
```dart
// This will return 400 error if 'username', 'email', 'password', or 'full_name' is missing
final response = await apiClient.createAdmin(
  username: 'new_admin',
  email: 'new@example.com',
  password: 'password123',
  fullName: 'New Admin',
);
```

## Adding New Mock Responses

1. **Create the JSON file** in `assets/mocks/api/` following the naming convention
2. **Add the endpoint method** to `MockApiClient` if it doesn't exist
3. **Update the required parameters** in the method call

Example:
```dart
// Add to MockApiClient
Future<http.Response> getNewEndpoint({
  required String param1,
  String? param2,
}) async {
  return await get(
    '/api/v1/new/endpoint',
    queryParams: {
      'param1': param1,
      if (param2 != null) 'param2': param2,
    },
    requiredQueryParams: ['param1'],
  );
}
```

## Switching Between Mock and Real APIs

### In Development
```dart
// Switch to mock mode
ref.read(apiServiceFactoryProvider.notifier).switchToMock();

// Switch to real mode (when implemented)
ref.read(apiServiceFactoryProvider.notifier).switchToReal();
```

### In Production
Set the environment variable to disable mock mode:
```bash
flutter run --dart-define=MOCK_API=false
```

## Benefits

1. **Fast Development**: No need to wait for real API responses
2. **Offline Testing**: Works without internet connection
3. **Consistent Data**: Same mock data every time
4. **Parameter Validation**: Catches missing parameters early
5. **Easy Testing**: Test different scenarios by editing JSON files
6. **No Backend Dependency**: Develop frontend without backend

## Troubleshooting

### Mock Response Not Found
- Check file naming convention
- Ensure file is in `assets/mocks/api/` directory
- Verify `pubspec.yaml` includes the assets directory

### Parameter Validation Errors
- Check that all required parameters are provided
- Verify parameter names match the API specification
- Check the `requiredQueryParams` and `requiredBodyFields` arrays

### Build Errors
- Run `flutter packages get` after adding new assets
- Run `dart run build_runner build` if using code generation
- Check that all imports are correct

## Next Steps

1. **Add more mock responses** for all your API endpoints
2. **Integrate with existing controllers** by replacing API calls
3. **Add error scenarios** by creating different JSON files for error responses
4. **Implement real API client** and update the factory to switch between them
5. **Add unit tests** using the mock API system

## Support

If you encounter any issues:
1. Check the console for error messages
2. Verify your JSON files are valid
3. Ensure all required parameters are provided
4. Check the file naming convention
