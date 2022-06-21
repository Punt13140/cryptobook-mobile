import 'package:cryptobook/provider/user_preferences.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith();

final lightTheme = ThemeData.light().copyWith(primaryColor: Colors.pink);

const String keyTheme = 'darkTheme';

class ThemeProvider with ChangeNotifier {
  final UserPreferences _userPreferences;

  ThemeProvider(this._userPreferences);

  bool get isDarkTheme => _userPreferences.isDarkTheme;

  ThemeData get currentTheme {
    return isDarkTheme ? darkTheme : lightTheme;
  }

  toggleTheme() {
    _userPreferences.setDarkTheme(!isDarkTheme);
    notifyListeners();
  }
}
