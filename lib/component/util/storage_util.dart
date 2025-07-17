import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../ext/string_ext.dart';

const _isMute = "isMute";
const _token = 'token';

extension StorageUtil on IStorage {
  Future<bool> isLoggedIn() async {
    return await getLoginToken() != null;
  }

  Future setLoginToken(String token) async {
    await write(
      key: _token,
      value: token,
    );
  }

  Future<String?> getLoginToken() async {
    return await read(
      key: _token,
    );
  }

  Future<bool> isMute() async {
    return await getIsMute() != null;
  }

  Future setIsMute(String mute) async {
    await write(
      key: _isMute,
      value: mute,
    );
  }

  Future<String?> getIsMute() async {
    return await read(
      key: _isMute,
    );
  }
}

class SecureStorage implements IStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  @override
  Future<bool> containKey({required String key}) {
    return _storage.containsKey(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() {
    return _storage.deleteAll();
  }

  @override
  Future<String?> read({required String key}) {
    return _storage.read(key: key);
  }

  @override
  Future<bool?> readBoolean({required String key}) {
    return _storage.read(key: key).then((value) => value?.parseBool());
  }

  @override
  Future<double?> readDouble({required String key}) {
    return _storage.read(key: key).then((value) => double.parse(value ?? ""));
  }

  @override
  Future<int?> readInt({required String key}) {
    return _storage.read(key: key).then((value) => int.tryParse(value ?? ""));
  }

  @override
  Future<void> write({required String key, required String? value}) {
    return _storage.write(key: key, value: value);
  }

  @override
  Future<bool> has(String key) async {
    return await _storage.read(key: key) != null;
  }
}

abstract class IStorage {
  Future<String?> read({required String key});
  Future<int?> readInt({required String key});
  Future<double?> readDouble({required String key});
  Future<bool?> readBoolean({required String key});

  Future<void> write({
    required String key,
    required String? value,
  });

  Future<bool> containKey({
    required String key,
  });

  Future<void> delete({
    required String key,
  });

  Future<void> deleteAll();

  Future<bool> has(String key);
}
