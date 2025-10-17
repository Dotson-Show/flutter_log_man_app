import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

/// Mock API Service that loads responses from local JSON files
/// and validates required parameters before returning responses
class MockApiService {
  static const String _mockDataPath = 'assets/mocks/api/';
  
  /// Check if mock mode is enabled
  static bool get isMockMode => const bool.fromEnvironment('MOCK_API', defaultValue: true);
  
  /// Load mock response from JSON file
  static Future<Map<String, dynamic>> _loadMockResponse(String endpoint, String method) async {
    try {
      final fileName = _getFileName(endpoint, method);
      final filePath = '$_mockDataPath$fileName';
      
      final jsonString = await rootBundle.loadString(filePath);
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load mock response for $method $endpoint: $e');
    }
  }
  
  /// Generate filename for mock response
  static String _getFileName(String endpoint, String method) {
    // Convert endpoint to filename: /api/v1/admin/admins -> admin_admins
    final cleanEndpoint = endpoint
        .replaceAll('/api/v1/', '')
        .replaceAll('/', '_')
        .replaceAll('{', '')
        .replaceAll('}', '');
    
    return '${cleanEndpoint}_$method.json';
  }
  
  /// Validate required parameters for an endpoint
  static bool _validateParameters(
    Map<String, dynamic> params,
    List<String> requiredParams,
    Map<String, dynamic>? body,
    List<String> requiredBodyFields,
  ) {
    // Check query parameters
    for (final param in requiredParams) {
      if (!params.containsKey(param) || params[param] == null) {
        return false;
      }
    }
    
    // Check body parameters
    if (body != null) {
      for (final field in requiredBodyFields) {
        if (!body.containsKey(field) || body[field] == null) {
          return false;
        }
      }
    }
    
    return true;
  }
  
  /// Make a mock API request
  static Future<http.Response> request({
    required String method,
    required String endpoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    List<String> requiredQueryParams = const [],
    List<String> requiredBodyFields = const [],
  }) async {
    if (!isMockMode) {
      throw Exception('Mock API service called but mock mode is disabled');
    }
    
    // Validate required parameters
    final params = queryParams ?? {};
    if (!_validateParameters(params, requiredQueryParams, body, requiredBodyFields)) {
      return http.Response(
        json.encode({
          'error': 'Missing required parameters',
          'message': 'One or more required parameters are missing',
          'code': 400,
        }),
        400,
        headers: {'content-type': 'application/json'},
      );
    }
    
    try {
      // Load mock response
      final mockResponse = await _loadMockResponse(endpoint, method.toLowerCase());
      
      // Extract status code and data
      final statusCode = mockResponse['statusCode'] ?? 200;
      final responseData = Map<String, dynamic>.from(mockResponse);
      responseData.remove('statusCode');
      
      return http.Response(
        json.encode(responseData),
        statusCode,
        headers: {'content-type': 'application/json'},
      );
    } catch (e) {
      return http.Response(
        json.encode({
          'error': 'Mock response error',
          'message': e.toString(),
          'code': 500,
        }),
        500,
        headers: {'content-type': 'application/json'},
      );
    }
  }
  
  /// GET request
  static Future<http.Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    List<String> requiredQueryParams = const [],
  }) {
    return request(
      method: 'GET',
      endpoint: endpoint,
      queryParams: queryParams,
      headers: headers,
      requiredQueryParams: requiredQueryParams,
    );
  }
  
  /// POST request
  static Future<http.Response> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    List<String> requiredBodyFields = const [],
  }) {
    return request(
      method: 'POST',
      endpoint: endpoint,
      body: body,
      headers: headers,
      requiredBodyFields: requiredBodyFields,
    );
  }
  
  /// PUT request
  static Future<http.Response> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    List<String> requiredBodyFields = const [],
  }) {
    return request(
      method: 'PUT',
      endpoint: endpoint,
      body: body,
      headers: headers,
      requiredBodyFields: requiredBodyFields,
    );
  }
  
  /// DELETE request
  static Future<http.Response> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) {
    return request(
      method: 'DELETE',
      endpoint: endpoint,
      headers: headers,
    );
  }
}
