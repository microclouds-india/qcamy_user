import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();
  factory LocalStorage() => _instance;
  LocalStorage._internal();

  final storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> setToken(String token) async {
    return await storage.write(key: 'token', value: token);
  }

  Future<void> deleteToken() async {
    return await storage.delete(key: 'token');
  }
}
