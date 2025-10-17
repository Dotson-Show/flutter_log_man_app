import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Model for User data
class UserData {
  final int id;
  final String username;
  final String email;
  final String userType;

  UserData({
    required this.id,
    required this.username,
    required this.email,
    required this.userType,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      userType: json['user_type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'user_type': userType,
    };
  }

  UserData copyWith({
    int? id,
    String? username,
    String? email,
    String? userType,
  }) {
    return UserData(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      userType: userType ?? this.userType,
    );
  }
}

/// Session Service for managing authentication state
class SessionService {
  final FlutterSecureStorage _storage;

  // Storage keys
  static const String _keyAccessToken = 'access_token';
  static const String _keyRefreshToken = 'refresh_token';
  static const String _keyUserData = 'user_data';
  static const String _keyPendingUserId = 'pending_user_id';

  SessionService(this._storage);

  /// Save complete session data (tokens + user)
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required UserData user,
  }) async {
    await Future.wait([
      _storage.write(key: _keyAccessToken, value: accessToken),
      _storage.write(key: _keyRefreshToken, value: refreshToken),
      _storage.write(key: _keyUserData, value: jsonEncode(user.toJson())),
    ]);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _keyAccessToken);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _keyRefreshToken);
  }

  /// Update access token (useful after token refresh)
  Future<void> updateAccessToken(String newAccessToken) async {
    await _storage.write(key: _keyAccessToken, value: newAccessToken);
  }

  /// Get user data
  Future<UserData?> getUserData() async {
    final userDataStr = await _storage.read(key: _keyUserData);
    if (userDataStr == null) return null;

    try {
      final json = jsonDecode(userDataStr) as Map<String, dynamic>;
      return UserData.fromJson(json);
    } catch (e) {
      return null;
    }
  }

  /// Update user data (useful for profile updates)
  Future<void> updateUserData(UserData user) async {
    await _storage.write(key: _keyUserData, value: jsonEncode(user.toJson()));
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all session data (logout)
  Future<void> clearSession() async {
    await Future.wait([
      _storage.delete(key: _keyAccessToken),
      _storage.delete(key: _keyRefreshToken),
      _storage.delete(key: _keyUserData),
      _storage.delete(key: _keyPendingUserId),
    ]);
  }

  /// Save pending user ID (during registration)
  Future<void> savePendingUserId(int userId) async {
    await _storage.write(key: _keyPendingUserId, value: userId.toString());
  }

  /// Get pending user ID
  Future<int?> getPendingUserId() async {
    final userIdStr = await _storage.read(key: _keyPendingUserId);
    return userIdStr != null ? int.tryParse(userIdStr) : null;
  }

  /// Clear pending user ID
  Future<void> clearPendingUserId() async {
    await _storage.delete(key: _keyPendingUserId);
  }

  /// Get complete session info for debugging
  Future<Map<String, dynamic>> getSessionInfo() async {
    final accessToken = await getAccessToken();
    final refreshToken = await getRefreshToken();
    final userData = await getUserData();

    return {
      'isAuthenticated': accessToken != null,
      'hasRefreshToken': refreshToken != null,
      'user': userData?.toJson(),
    };
  }
}