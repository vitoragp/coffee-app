import 'dart:convert';

import 'package:coffee_base_app/models/model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///
/// Storage
///

class Storage {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  contains(String key) async => await _storage.containsKey(key: key);

  Future<String> readString(String key) async {
    if (!await contains(key)) {
      throw Exception("Storage '$key' not exist!");
    }
    var content = await _storage.read(key: key);
    return content!;
  }

  Future<void> writeString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<T> readModel<T extends Model>(String key) async {
    if (!await contains(key)) {
      throw Exception("Storage '$key' not exist!");
    }
    var content = await _storage.read(key: key);
    if (content == null) {
      throw Exception("Failed to read storage '$key'!");
    }
    return Model.serialize(jsonDecode(content));
  }

  Future<void> writeModel<T extends Model>(String key, T value) async {
    String jsonStr = jsonEncode(Model.deserialize(value));
    await _storage.write(key: key, value: jsonStr);
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
