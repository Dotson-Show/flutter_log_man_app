import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_config.dart';

final apiClientProvider = Provider<ApiClient>((ref) {
  final storage = const FlutterSecureStorage();
  return ApiClient(storage);
});

/// Enhanced API Client with automatic token injection and refresh
class ApiClient {
  final FlutterSecureStorage storage;
  late final Dio dio;

  ApiClient(this.storage) {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.add(_AuthInterceptor(storage, dio));

    // Optional: Add logging interceptor for debugging
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }
}

/// Interceptor to automatically add auth token and handle token refresh
class _AuthInterceptor extends Interceptor {
  final FlutterSecureStorage storage;
  final Dio dio;

  _AuthInterceptor(this.storage, this.dio);

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    // Skip token injection for auth endpoints
    if (_isAuthEndpoint(options.path)) {
      return handler.next(options);
    }

    // Get and inject access token
    final accessToken = await storage.read(key: 'access_token');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Handle 401 Unauthorized - token expired
    if (err.response?.statusCode == 401) {
      // Skip refresh for auth endpoints
      if (_isAuthEndpoint(err.requestOptions.path)) {
        return handler.next(err);
      }

      try {
        // Attempt to refresh token
        await _refreshToken();

        // Retry the original request with new token
        final response = await _retry(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        // Refresh failed, clear session and force re-login
        await _clearSession();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  /// Refresh the access token
  Future<void> _refreshToken() async {
    final refreshToken = await storage.read(key: 'refresh_token');

    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await dio.post(
      '/auth/refresh',
      data: {'refresh_token': refreshToken},
      options: Options(
        headers: {'Authorization': 'Bearer $refreshToken'},
      ),
    );

    final newAccessToken = response.data['access_token'] as String;
    await storage.write(key: 'access_token', value: newAccessToken);

    // Optional: Update refresh token if API returns a new one
    if (response.data.containsKey('refresh_token')) {
      final newRefreshToken = response.data['refresh_token'] as String;
      await storage.write(key: 'refresh_token', value: newRefreshToken);
    }
  }

  /// Retry the failed request with new token
  Future<Response> _retry(RequestOptions requestOptions) async {
    final accessToken = await storage.read(key: 'access_token');

    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $accessToken',
      },
    );

    return dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  /// Clear session data
  Future<void> _clearSession() async {
    await Future.wait([
      storage.delete(key: 'access_token'),
      storage.delete(key: 'refresh_token'),
      storage.delete(key: 'user_data'),
    ]);
  }

  /// Check if endpoint is an auth endpoint (don't inject token)
  bool _isAuthEndpoint(String path) {
    final authPaths = [
      '/auth/login',
      '/auth/register',
      '/auth/verify',
      '/auth/resend-otp',
      '/auth/reset-password',
      '/auth/refresh',
    ];

    return authPaths.any((authPath) => path.contains(authPath));
  }
}