import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  UserPreferences._shared(final SharedPreferences sharedPreferences) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static Future<UserPreferences> getUserPreferences() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return UserPreferences._shared(preferences);
  }

  static const String keyDarkTheme = 'isDarkTheme';

  Future<void> setDarkTheme(final bool isDarkTheme) async {
    await _sharedPreferences.setBool(keyDarkTheme, isDarkTheme);
    notifyListeners();
  }

  bool get isDarkTheme => _sharedPreferences.getBool(keyDarkTheme) ?? true;
}
