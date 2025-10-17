import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../core/api_client.dart';
import '../services/auth_service.dart';
import '../../../core/session_service.dart';

part 'auth_controller.g.dart';

// ============================================================================
// PROVIDERS
// ============================================================================

/// Session Service Provider
@riverpod
SessionService sessionService(Ref ref) {
  final storage = const FlutterSecureStorage();
  return SessionService(storage);
}

/// Auth Service Provider
@riverpod
AuthService authService(Ref ref) {
  final storage = const FlutterSecureStorage();
  final api = ApiClient(storage);
  final sessionService = ref.watch(sessionServiceProvider);
  return AuthService(api, sessionService);
}

/// Current User Provider - watches the current authenticated user
@riverpod
Future<UserData?> currentUser(Ref ref) async {
  final sessionService = ref.watch(sessionServiceProvider);
  return await sessionService.getUserData();
}

/// Authentication Status Provider
@riverpod
Future<bool> isAuthenticated(Ref ref) async {
  final sessionService = ref.watch(sessionServiceProvider);
  return await sessionService.isAuthenticated();
}

// ============================================================================
// CONTROLLERS
// ============================================================================

@riverpod
class LoginController extends _$LoginController {
  @override
  FutureOr<void> build() {}

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    try {
      await ref.read(authServiceProvider).login(email, password);

      // Invalidate user-related providers to trigger refresh
      ref.invalidate(currentUserProvider);
      ref.invalidate(isAuthenticatedProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

@riverpod
class RegisterController extends _$RegisterController {
  @override
  FutureOr<void> build() {}

  Future<void> register(
      String name,
      String email,
      String userType,
      String password,
      String phone,
      ) async {
    state = const AsyncLoading();
    try {
      await ref.read(authServiceProvider).register(
        name,
        email,
        userType,
        password,
        phone,
      );
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

@riverpod
class VerifyController extends _$VerifyController {
  @override
  FutureOr<void> build() {}

  Future<void> verify(String otp) async {
    state = const AsyncLoading();
    try {
      final sessionService = ref.read(sessionServiceProvider);
      final userId = await sessionService.getPendingUserId();

      if (userId == null) {
        throw Exception('User ID not found. Please register again.');
      }

      await ref.read(authServiceProvider).verifyPhone(otp, userId);

      // Invalidate user-related providers to trigger refresh
      ref.invalidate(currentUserProvider);
      ref.invalidate(isAuthenticatedProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> resendOtp() async {
    state = const AsyncLoading();
    try {
      final sessionService = ref.read(sessionServiceProvider);
      final userId = await sessionService.getPendingUserId();

      if (userId == null) {
        throw Exception('User ID not found. Please register again.');
      }

      await ref.read(authServiceProvider).resendOtp(userId);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

@riverpod
class LogoutController extends _$LogoutController {
  @override
  FutureOr<void> build() {}

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await ref.read(authServiceProvider).logout();

      // Invalidate all user-related providers
      ref.invalidate(currentUserProvider);
      ref.invalidate(isAuthenticatedProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

@riverpod
class ResetPasswordController extends _$ResetPasswordController {
  @override
  FutureOr<void> build() {}

  Future<void> resetPassword(String email) async {
    state = const AsyncLoading();
    try {
      await ref.read(authServiceProvider).resetPassword(email);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}