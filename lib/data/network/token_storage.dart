import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const storageKey = 'auth_token';
  static const userIdKey = 'auth_user_id';
  final FlutterSecureStorage storage;

  TokenStorage([this.storage = const FlutterSecureStorage()]);

  Future<String?> read() => storage.read(key: storageKey);

  Future<void> write(String token) => storage.write(key: storageKey, value: token);

  Future<int?> readUserId() async {
    final value = await storage.read(key: userIdKey);
    return value == null ? null : int.tryParse(value);
  }

  Future<void> writeUserId(int userId) =>
      storage.write(key: userIdKey, value: '$userId');

  Future<void> clear() async {
    await storage.delete(key: storageKey);
    await storage.delete(key: userIdKey);
  }
}
