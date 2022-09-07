import 'package:flutter/material.dart';

class ContentPageLoading extends StatelessWidget {
  const ContentPageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Chargement en cours'),
          SizedBox(
            height: 10.0,
          ),
          CircularProgressIndicator.adaptive(),
        ],
      ),
    );
  }
}

class FullPageLoading extends StatelessWidget {
  const FullPageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cryptobook'),
        ),
        body: const ContentPageLoading());
  }
}

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  static void hide(BuildContext context) => Navigator.pop(context);
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
