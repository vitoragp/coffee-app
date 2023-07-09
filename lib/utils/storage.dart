import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///
/// Storage
///

class Storage {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  contains(String key) async => await _storage.containsKey(key: key);

  Future<String> read(String key) async {
    if (!await contains(key)) {
      throw Exception("Storage '$key' not exist!");
    }
    var content = await _storage.read(key: key);
    return content!;
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
