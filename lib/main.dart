import 'package:cryptobook/provider/theme.dart';
import 'package:cryptobook/provider/user_preferences.dart';
import 'package:cryptobook/view/dashboard_screen.dart';
import 'package:cryptobook/view/farmings/farmings_screen.dart';
import 'package:cryptobook/view/login_screen.dart';
import 'package:cryptobook/view/positions/position_form.dart';
import 'package:cryptobook/view/positions/positions_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Cryptobook());
}

class Cryptobook extends StatefulWidget {
  const Cryptobook({Key? key}) : super(key: key);

  @override
  State<Cryptobook> createState() => _CryptobookState();
}

class _CryptobookState extends State<Cryptobook> {
  late UserPreferences _userPreferences;
  late Future<void> _initFuture;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initFuture,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text('Pas de connexion.');
          case ConnectionState.waiting:
            return const CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return MultiProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => ThemeProvider(_userPreferences)),
              ],
              builder: _materialApp,
            );
        }
      },
    );
  }

  Widget _materialApp(BuildContext context, Widget? child) {
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.currentTheme,
      home: const CheckUserPage(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashBoardScreen(),
        '/positions': (context) => const PositionsScreen(),
        '/position-form': (context) => const PositionForm(),
        '/farmings': (context) => const FarmingsScreen(),
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initFuture = init();
  }

  Future<void> init() async {
    _userPreferences = await UserPreferences.getUserPreferences();
  }
}
