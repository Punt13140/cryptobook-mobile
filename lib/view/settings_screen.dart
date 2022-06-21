import 'package:cryptobook/blocs/bloc_user_auth.dart';
import 'package:cryptobook/utils/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../provider/theme.dart';
import '../utils/storage.dart';
import '../utils/widgets/loading.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAuthBloc>(
      create: (_) => UserAuthBloc(),
      //lazy: true,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Paramètres'),
        ),
        body: BlocBuilder<UserAuthBloc, UserAuthBlocState>(
          buildWhen: (oldState, newState) => oldState.userAuth == null,
          builder: (_, UserAuthBlocState state) {
            if (state.userAuth != null) {
              return const ContentPageWithUser();
            }
            return const ContentPageLoading();
          },
        ),
        bottomNavigationBar: const BottomBar(
          position: 2,
        ),
      ),
    );
  }
}

class ContentPageWithUser extends StatelessWidget {
  const ContentPageWithUser({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              HeaderContent(),
              ToggleContent(),
              ButtonsContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderContent extends StatelessWidget {
  const HeaderContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAuthBloc, UserAuthBlocState>(
      buildWhen: (oldState, newState) => oldState.userAuth != newState.userAuth,
      builder: (_, UserAuthBlocState state) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  radius: 20.0,
                  child: Icon(Icons.person),
                ),
                title: Text(state.userAuth!.getEmail()),
              )
            ],
          ),
        );
      },
    );
  }
}

class ToggleContent extends StatelessWidget {
  const ToggleContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<ThemeProvider>(
            builder: (context, notifier, child) => ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch(
                value: notifier.isDarkTheme,
                onChanged: (bool value) {
                  notifier.toggleTheme();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ButtonsContent extends StatefulWidget {
  const ButtonsContent({Key? key}) : super(key: key);

  @override
  State<ButtonsContent> createState() => _ButtonsContentState();
}

class _ButtonsContentState extends State<ButtonsContent> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<UserAuthBloc, UserAuthBlocState>(
            buildWhen: (oldState, newState) => oldState.userAuth != newState.userAuth,
            builder: (_, UserAuthBlocState state) {
              return ListTile(
                title: const Text('Deconnexion'),
                trailing: const Icon(Icons.logout),
                onTap: () async {
                  await _handleDisconnect();
                  if (mounted) {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _handleDisconnect() async {
    await Storage().removeUser();
  }
}
