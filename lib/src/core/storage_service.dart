import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'storage_service.g.dart';

class StorageService {
  final FlutterSecureStorage _storage;

  StorageService(): _storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> setToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: 'access_token');
  }
}

@riverpod
StorageService storageService(Ref ref) {
  return StorageService();
}