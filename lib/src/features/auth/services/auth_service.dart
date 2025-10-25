import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/api_client.dart';
import '../../../utils/error_parser.dart';
import '../../../core/session_service.dart';

class AuthService {
  final ApiClient apiClient;
  final SessionService sessionService;

  AuthService(this.apiClient, this.sessionService);

  /// Login user and save session
  Future<void> login(String email, String password) async {
    try {
      final res = await apiClient.dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      await _saveSessionFromResponse(res.data);
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  /// Register user and return user_id
  Future<int> register(
      String name,
      String email,
      String userType,
      String password,
      String phone,
      ) async {
    String username = email.split('@')[0];
    try {
      final res = await apiClient.dio.post('/auth/register', data: {
        'username': username,
        'full_name': name,
        'email': email,
        'user_type': userType,
        'password': password,
        'phone_number': phone,
      });

      // Extract and store user_id for verification
      final userId = res.data['user_id'] as int;
      await sessionService.savePendingUserId(userId);

      return userId;
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  /// Verify phone and save session
  Future<void> verifyPhone(String otp, int userId) async {
    try {
      final res = await apiClient.dio.post('/auth/verify', data: {
        'code': otp,
        'user_id': userId,
      });

      // Save complete session after successful verification
      await _saveSessionFromResponse(res.data);

      // Clear pending user_id
      await sessionService.clearPendingUserId();
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  /// Resend OTP
  Future<void> resendOtp(int userId) async {
    try {
      await apiClient.dio.post('/auth/resend-otp', data: {
        'user_id': userId,
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  /// Refresh access token
  Future<void> refreshAccessToken() async {
    try {
      final refreshToken = await sessionService.getRefreshToken();

      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final res = await apiClient.dio.post('/auth/refresh', data: {
        'refresh_token': refreshToken,
      });

      final newAccessToken = res.data['access_token'] as String;
      await sessionService.updateAccessToken(newAccessToken);
    } on DioException catch (e) {
      // If refresh fails, clear session and force re-login
      await sessionService.clearSession();
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  /// Logout user - ALWAYS succeeds
  Future<void> logout() async {
    print('🚪 AuthService.logout() called');

    // Step 1: Try server logout (optional, non-blocking)
    try {
      print('📡 Attempting server logout...');
      await apiClient.dio.post(
        '/auth/logout',
        options: Options(
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      ).timeout(const Duration(seconds: 5));
      print('✅ Server logout successful');
    } catch (e) {
      print('⚠️ Server logout failed (continuing): $e');
    }

    // Step 2: ALWAYS clear local session (critical)
    try {
      print('🗑️ Clearing local session...');
      await sessionService.clearSession();
      print('✅ Local session cleared');
    } catch (e) {
      print('❌ Session clear failed: $e');
      // Try one more time
      try {
        print('🔄 Retrying session clear...');
        await sessionService.clearSession();
        print('✅ Session cleared on retry');
      } catch (e2) {
        print('❌ Session clear retry failed: $e2');
        // Don't throw - we've done our best
      }
    }

    print('✅ AuthService.logout() completed');
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await apiClient.dio.post('/auth/reset-password', data: {
        'email': email,
      });
    } on DioException catch (e) {
      throw Exception(ErrorParser.parseFromDioException(e));
    }
  }

  /// Get current user data
  Future<UserData?> getCurrentUser() async {
    return await sessionService.getUserData();
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return await sessionService.isAuthenticated();
  }

  /// Helper method to save session from API response
  Future<void> _saveSessionFromResponse(Map<String, dynamic> data) async {
    final accessToken = data['access_token'] as String;
    final refreshToken = data['refresh_token'] as String;
    final userJson = data['user'] as Map<String, dynamic>;

    final user = UserData.fromJson(userJson);

    await sessionService.saveSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user,
    );
  }
}