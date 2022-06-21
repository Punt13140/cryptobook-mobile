import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences extends ChangeNotifier {
  UserPreferences._shared(final SharedPreferences sharedPreferences) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  static Future<UserPreferences> getUserPreferences() async {
    debugPrint('ici');
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return UserPreferences._shared(preferences);
  }

  static const String _KEY_DARK_THEME = 'isDarkTheme';

  Future<void> setDarkTheme(final bool isDarkTheme) async {
    await _sharedPreferences.setBool(_KEY_DARK_THEME, isDarkTheme);
    notifyListeners();
  }

  bool get isDarkTheme => _sharedPreferences.getBool(_KEY_DARK_THEME) ?? true;
}
