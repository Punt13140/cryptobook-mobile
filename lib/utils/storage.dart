import 'package:cryptobook/model/user_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final _storage = const FlutterSecureStorage();
  final _accountNameController = TextEditingController(text: 'flutter_secure_storage_service');
  static const String _token = 'jwt_token';
  static const String _refreshToken = 'jwt_refresh_token';

  Future<void> saveUserAuth(UserAuth userAuth) async {
    _storage.write(
      key: _token,
      value: userAuth.token,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
    _storage.write(
      key: _refreshToken,
      value: userAuth.refreshToken,
      iOptions: _getIOSOptions(),
      aOptions: _getAndroidOptions(),
    );
  }

  Future<UserAuth?> getUser() async {
    String? token = await _storage.read(key: _token);
    String? refreshToken = await _storage.read(key: _refreshToken);
    if (token == null || token.isEmpty || refreshToken == null || refreshToken.isEmpty) {
      return null;
    }
    return UserAuth(token, refreshToken);
  }

  Future<void> removeUser() async {
    _storage.delete(key: _token);
    _storage.delete(key: _refreshToken);
  }

  IOSOptions _getIOSOptions() => IOSOptions(
        accountName: _getAccountName(),
      );

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
      //encryptedSharedPreferences: true,
      );

  String? _getAccountName() => _accountNameController.text.isEmpty ? null : _accountNameController.text;
}
