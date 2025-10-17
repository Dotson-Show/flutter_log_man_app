// ========================================
// 1. ERROR MESSAGE PARSER UTILITY
// utils/error_parser.dart
// ========================================
import 'package:dio/dio.dart';

class ErrorParser {
  // Parse DioException directly to get structured backend errors
  static String parseFromDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    // Handle special cases first (override backend messages)
    if (statusCode != null) {
      final specialCase = _handleSpecialCases(statusCode, responseData);
      if (specialCase != null) return specialCase;
    }

    // Try to extract backend error message
    final backendMessage = _extractBackendMessage(responseData);
    if (backendMessage != null) return backendMessage;

    // Fallback to parsing the dio error message string
    return parse(error.message ?? 'Unknown error occurred');
  }

  // Handle special cases where you want to override backend messages
  static String? _handleSpecialCases(int statusCode, dynamic responseData) {
    switch (statusCode) {
      case 404:
      // Check if it's a user not found vs general 404
        if (responseData is Map<String, dynamic>) {
          final message = responseData['message']?.toString().toLowerCase() ?? '';
          if (message.contains('user') && message.contains('not found')) {
            return 'No account found with this email address.';
          }
        }
        break;

      case 401:
        return 'Invalid email or password. Please try again.';

      case 403:
        return 'Access denied. Please contact support.';

      case 429:
        return 'Too many attempts. Please try again later.';

      case 500:
      case 502:
      case 503:
      case 504:
        print('Got here now');
        return 'Service temporarily unavailable. Please try again later.';
    }

    return null; // No special case, use backend message
  }

  // Extract the actual error message from backend response
  static String? _extractBackendMessage(dynamic responseData) {
    if (responseData == null) return null;

    if (responseData is Map<String, dynamic>) {
      // Handle validation errors format: {errors: {...}, message: "...", status: "..."}
      if (responseData['errors'] != null && responseData['errors'] is Map<String, dynamic>) {
        return _formatValidationErrors(responseData['errors'] as Map<String, dynamic>);
      }

      // Handle simple message format: {message: "...", error: "..."}
      if (responseData['message'] != null) {
        return responseData['message'].toString();
      }

      if (responseData['error'] != null) {
        return responseData['error'].toString();
      }

      // Handle detail field (common in some APIs)
      if (responseData['detail'] != null) {
        return responseData['detail'].toString();
      }
    }

    // If it's just a string
    if (responseData is String) {
      return responseData;
    }

    return null;
  }

  // Format validation errors into user-friendly message
  static String _formatValidationErrors(Map<String, dynamic> errors) {
    final List<String> errorMessages = [];

    errors.forEach((field, fieldErrors) {
      if (fieldErrors is List && fieldErrors.isNotEmpty) {
        // Convert field name to user-friendly format
        final friendlyField = _fieldNameToFriendly(field);
        final firstError = fieldErrors.first.toString();
        errorMessages.add('$friendlyField: $firstError');
      }
    });

    if (errorMessages.isEmpty) {
      return 'Please check your input and try again.';
    }

    if (errorMessages.length == 1) {
      return errorMessages.first;
    }

    return errorMessages.join('\n');
  }

  // Convert field names to user-friendly names
  static String _fieldNameToFriendly(String field) {
    switch (field.toLowerCase()) {
      case 'user_type':
        return 'User type';
      case 'username':
        return 'Username';
      case 'email':
        return 'Email';
      case 'password':
        return 'Password';
      case 'full_name':
        return 'Full name';
      case 'phone_number':
        return 'Phone number';
      default:
      // Convert snake_case to Title Case
        return field.replaceAll('_', ' ').split(' ')
            .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase())
            .join(' ');
    }
  }

  // Your original string-based parser (now as fallback)
  static String parse(String error) {
    final lowerError = error.toLowerCase();
    print('status code ');
    print("ErrorParserMessage: $lowerError");

    // Authentication errors
    if (lowerError.contains('404') || lowerError.contains('user not found') || lowerError.contains('no account found')) {
      return 'No account found with this email address.';
    }
    if (lowerError.contains('401') || lowerError.contains('invalid credentials') || lowerError.contains('unauthorized')) {
      return 'Invalid email or password. Please try again.';
    }
    if (lowerError.contains('403') || lowerError.contains('forbidden')) {
      return 'Access denied. Please contact support.';
    }
    if (lowerError.contains('429') || lowerError.contains('too many requests')) {
      return 'Too many attempts. Please try again later.';
    }

    // Network errors
    if (lowerError.contains('network') || lowerError.contains('connection')) {
      return 'Network error. Please check your connection.';
    }
    if (lowerError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (lowerError.contains('host') || lowerError.contains('dns')) {
      return 'Unable to connect to server. Please try again.';
    }

    // Validation errors
    if (lowerError.contains('email') && lowerError.contains('invalid')) {
      return 'Please enter a valid email address.';
    }
    if (lowerError.contains('password') && lowerError.contains('weak')) {
      return 'Password is too weak. Please choose a stronger password.';
    }
    if (lowerError.contains('password') && lowerError.contains('short')) {
      return 'Password is too short. Please use at least 8 characters.';
    }

    // Registration errors
    if (lowerError.contains('email') && lowerError.contains('exists')) {
      return 'An account with this email already exists.';
    }
    if (lowerError.contains('username') && lowerError.contains('taken')) {
      return 'This username is already taken.';
    }

    // Server errors
    if (lowerError.contains('500') || lowerError.contains('internal server')) {
      return 'Server error. Please try again later.';
    }
    if (lowerError.contains('502') || lowerError.contains('503') || lowerError.contains('504')) {
      print('Got here');
      return 'Service temporarily unavailable. Please try again later.';
    }

    // Generic fallback
    return 'Something went wrong. Please try again.';
  }

  // Method to get suggestion based on error type
  static String? getSuggestion(String error) {
    final lowerError = error.toLowerCase();

    if (lowerError.contains('404') || lowerError.contains('user not found')) {
      return 'Check your email address or create a new account.';
    }
    if (lowerError.contains('network') || lowerError.contains('connection')) {
      return 'Check your internet connection and try again.';
    }
    if (lowerError.contains('429')) {
      return 'Wait a few minutes before trying again.';
    }

    return null;
  }

  // Get status code from DioException
  static int? getStatusCode(DioException error) {
    return error.response?.statusCode;
  }

  // Check if error is a validation error
  static bool isValidationError(DioException error) {
    final responseData = error.response?.data;
    return responseData is Map<String, dynamic> &&
        responseData['errors'] != null &&
        responseData['errors'] is Map<String, dynamic>;
  }
}