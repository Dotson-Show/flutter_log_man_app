import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'comprehensive_mock_api_client.dart';
// import 'real_api_client.dart'; // Uncomment when you have your real API client

part 'api_service_factory.g.dart';

/// Factory that provides either mock or real API client based on configuration
@riverpod
class ApiServiceFactory extends _$ApiServiceFactory {
  @override
  dynamic build() {
    // Check if mock mode is enabled
    const bool mockMode = bool.fromEnvironment('MOCK_API', defaultValue: true);
    
    if (mockMode) {
      return ComprehensiveMockApiClient();
    } else {
      // Return your real API client here
      // return RealApiClient();
      throw UnimplementedError('Real API client not implemented yet');
    }
  }
  
  /// Get the current API client (mock or real)
  dynamic get apiClient => state;
  
  /// Check if currently using mock API
  bool get isMockMode => ComprehensiveMockApiClient.isMockMode;
  
  /// Switch to mock mode (for testing)
  void switchToMock() {
    state = ComprehensiveMockApiClient();
  }
  
  /// Switch to real mode (for production)
  void switchToReal() {
    // state = RealApiClient();
    throw UnimplementedError('Real API client not implemented yet');
  }
}
