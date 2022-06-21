import 'package:cryptobook/blocs/bloc_user_auth.dart';
import 'package:cryptobook/provider/theme.dart';
import 'package:cryptobook/provider/user_preferences.dart';
import 'package:cryptobook/utils/widgets/loading.dart';
import 'package:cryptobook/view/dashboard_screen.dart';
import 'package:cryptobook/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

        return Container();
      },
    );
  }

  Widget _materialApp(BuildContext context, Widget? child) {
    final ThemeProvider themeProvider = context.watch<ThemeProvider>();

    /*   return MaterialApp.router(
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'Cryptobook',
      theme: themeProvider.currentTheme,
    );
*/
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeProvider.currentTheme,
      home: const ContentPage(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashBoardScreen(),
      },
    );
  }

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const Cryptobook(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (BuildContext context, GoRouterState state) => const DashBoardScreen(),
      ),
    ],
  );

  @override
  void initState() {
    super.initState();
    _initFuture = init();
  }

  Future<void> init() async {
    _userPreferences = await UserPreferences.getUserPreferences();
  }
}

//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => ThemeProvider(),
//       child: Consumer<ThemeProvider>(
//         builder: (context, ThemeProvider notifier, child) {
//           return MaterialApp(
//             title: 'Flutter Demo',
//             theme: notifier.isDarkTheme ? darkTheme : lightTheme,
//             home: const ContentPage(),
//           );
//         },
//       ),
//     );
//   }
// }
//
class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAuthBloc>(
      create: (_) => UserAuthBloc(),
      lazy: true,
      child: Scaffold(
        body: BlocBuilder<UserAuthBloc, UserAuthBlocState>(
          buildWhen: (oldState, newState) => oldState.userAuth == null,
          builder: (_, UserAuthBlocState state) {
            if (state.isLoading) {
              return const ContentPageLoading();
            } else if (state.userAuth != null) {
              return const DashBoardScreen();
            } else {
              return const LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
