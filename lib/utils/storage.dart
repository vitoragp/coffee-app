import 'dart:convert';

import 'package:coffee_base_app/domain/models/model.dart';
import 'package:coffee_base_app/factories/model_factory.dart';
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

  Future<T?> readModel<T extends Model>(String key) async {
    final modelStr = await read(key);
    final modelJson = jsonDecode(modelStr) as Map<String, dynamic>;
    return Future(() => ModelFactory.deserialize(modelJson) as T);
  }

  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> writeModel<T extends Model>(String key, T model) async {
    await write(key, jsonEncode(ModelFactory.serialize<T>(model)));
  }

  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
