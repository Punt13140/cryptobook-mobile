import 'package:cryptobook/utils/widgets/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PositionsScreen extends StatelessWidget {
  const PositionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Positions'),
      ),
      body: Container(),
      bottomNavigationBar: const BottomBar(
        position: 1,
      ),
    );
  }
}
