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
