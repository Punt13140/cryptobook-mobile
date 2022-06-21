import 'package:cryptobook/utils/api.dart';
import 'package:flutter/material.dart';

import '../model/user_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  bool _formHasError = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptobook'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  autocorrect: false,
                  onChanged: (value) {
                    _email = value;
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
                ),
                TextFormField(
                  onChanged: (value) {
                    _password = value;
                  },
                  obscureText: true,
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
                ),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            setState(() {
                              _isLoading = true;
                            });
                            bool loggedIn = await _handleLogin();
                            setState(() {
                              _isLoading = false;
                            });

                            if (loggedIn) {
                              if (mounted) {
                                Navigator.pushReplacementNamed(context, '/dashboard');
                              }
                            }
                          }
                        },
                        child: const Text('Submit'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _handleLogin() async {
    UserAuth? user = await NetworkManager().getUserAuth(_email, _password);
    return user != null;
  }
}
