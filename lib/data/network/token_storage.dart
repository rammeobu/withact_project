import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const storageKey = 'auth_token';
  final FlutterSecureStorage storage;

  TokenStorage([this.storage = const FlutterSecureStorage()]);

  Future<String?> read() => storage.read(key: storageKey);

  Future<void> write(String token) => storage.write(key: storageKey, value: token);

  Future<void> clear() => storage.delete(key: storageKey);
}
