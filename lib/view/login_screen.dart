import 'package:cryptobook/blocs/bloc_user_auth.dart';
import 'package:cryptobook/utils/view_state.dart';
import 'package:cryptobook/utils/widgets/loading.dart';
import 'package:cryptobook/view/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckUserPage extends StatelessWidget {
  const CheckUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserAuthBloc>(
        create: (_) => UserAuthBloc(),
        lazy: true,
        child: BlocBuilder<UserAuthBloc, UserAuthBlocState>(
          buildWhen: (oldState, newState) =>
              oldState.status == ViewStatus.initial || oldState.userAuth != newState.userAuth,
          builder: (_, UserAuthBlocState state) {
            if (state.status == ViewStatus.initial) {
              return const FullPageLoading();
            } else if (state.userAuth == null) {
              return const LoginScreen();
            }
            return const DashBoardScreen();
          },
        ));
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptobook'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: AutofillGroup(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                EmailField(),
                PasswordField(),
                ConnectionButtonField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAuthBloc, UserAuthBlocState>(
      buildWhen: (oldState, newState) => oldState.email == null,
      builder: (_, UserAuthBlocState state) {
        return TextFormField(
          autofillHints: const [AutofillHints.email],
          autocorrect: false,
          onChanged: (value) {
            //_email = value;
            BlocProvider.of<UserAuthBloc>(context).add(
              EmailChangedEvent(value),
            );
          },
          decoration: const InputDecoration(
            icon: Icon(Icons.alternate_email),
            hintText: "btc4life@crypto.com",
            labelText: "Email",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'l\'email est obligatoire';
            }
            return null;
          },
        );
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAuthBloc, UserAuthBlocState>(
      buildWhen: (oldState, newState) => oldState.password == null,
      builder: (_, UserAuthBlocState state) {
        return TextFormField(
          onChanged: (value) {
            //  _password = value;
            BlocProvider.of<UserAuthBloc>(context).add(
              PasswordChangedEvent(value),
            );
          },
          autofillHints: const [AutofillHints.password],
          obscureText: false,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            icon: Icon(Icons.lock),
            labelText: "Mot de passe",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'le mot de passe est obligatoire';
            }
            return null;
          },
        );
      },
    );
  }
}

class ConnectionButtonField extends StatelessWidget {
  const ConnectionButtonField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAuthBloc, UserAuthBlocState>(
      buildWhen: (oldState, newState) => oldState.isConnecting != newState.isConnecting,
      builder: (_, UserAuthBlocState state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<UserAuthBloc>(context).add(
                    const ConnectEvent(),
                  );

                  if (state.userAuth != null) {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  }
                },
                child: state.isConnecting ? const CircularProgressIndicator.adaptive() : const Text("Connexion"),
              ),
            ),
            if (state.error != null) Text(state.error!)
          ],
        );
      },
    );
  }
}
