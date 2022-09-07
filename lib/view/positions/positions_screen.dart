import 'package:badges/badges.dart';
import 'package:cryptobook/blocs/position/bloc_positions.dart';
import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/util.dart';
import 'package:cryptobook/utils/widgets/bottom_bar.dart';
import 'package:cryptobook/view/positions/positions_coin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PositionsScreen extends StatelessWidget {
  const PositionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Positions'),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.currency_bitcoin)),
              Tab(icon: Icon(Icons.euro_symbol)),
              Tab(icon: Icon(Icons.money_off)),
            ])),
        body: BlocProvider<PositionsBloc>(
          create: (_) => PositionsBloc(),
          child: const TabBarView(
            children: [
              CryptoOpenedWidget(),
              StableOpenedWidget(),
              ClosedWidget(),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(
          position: 1,
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/position-form');
        //   },
        //   tooltip: 'Ajouter une position',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}

class CryptoOpenedWidget extends StatelessWidget {
  const CryptoOpenedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionsBloc, PositionsBlocState>(
      buildWhen: (oldState, newState) => oldState.groupedPosCryptoOpened.isEmpty,
      builder: (_, PositionsBlocState state) {
        if (state.groupedPosCryptoOpened.isNotEmpty) {
          return ListViewPositionsGrouped(
            positions: state.groupedPosCryptoOpened,
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class StableOpenedWidget extends StatelessWidget {
  const StableOpenedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionsBloc, PositionsBlocState>(
      buildWhen: (oldState, newState) => oldState.groupedPosStableOpened.isEmpty,
      builder: (_, PositionsBlocState state) {
        if (state.groupedPosStableOpened.isNotEmpty) {
          return ListViewPositionsGrouped(
            positions: state.groupedPosStableOpened,
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class ClosedWidget extends StatelessWidget {
  const ClosedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionsBloc, PositionsBlocState>(
      buildWhen: (oldState, newState) => oldState.groupedPosClosed.isEmpty,
      builder: (_, PositionsBlocState state) {
        if (state.groupedPosClosed.isNotEmpty) {
          return ListViewPositionsGrouped(
            positions: state.groupedPosClosed,
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class ListViewPositionsGrouped extends StatelessWidget {
  const ListViewPositionsGrouped({Key? key, required this.positions}) : super(key: key);
  final Map<Cryptocurrency, Map<String, dynamic>> positions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: positions.length,
        itemBuilder: (BuildContext context, int index) {
          Cryptocurrency coin = positions.keys.elementAt(index);
          double value = coin.priceUsd * positions[coin]!['nbTotal'];
          String totalCoinFormated = nbCoinsFormated(positions[coin]!['nbTotal']);

          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, a1, a2) => PositionsByCoin(
                        positions: positions[coin]!['positions'],
                        coin: coin,
                      ),
                    ));
              },
              leading: Badge(
                badgeContent: Text(
                  positions[coin]!['nbPositions'].toString(),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                badgeColor: Theme.of(context).colorScheme.secondary,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(coin.urlImgThumb),
                ),
              ),
              title: Text('$totalCoinFormated ${coin.symbol.toUpperCase()}'),
              subtitle: Text('~ \$${value.toInt().toString()}'),
              trailing: const Icon(Icons.arrow_right),
            ),
          );
        },
      ),
    );
  }
}

class PositionDialogContent extends StatelessWidget {
  const PositionDialogContent({Key? key, required this.position}) : super(key: key);
  final Position position;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Text('Ouverte le ${position.openedAt.toLocal().toString()}'),
        Text('Nombre acheté ${position.nbCoins.toString()}'),
        Text('Nombre restant ${position.remainingCoins.toString()}'),
        Text('Valeur actuelle \$${position.currentValue.toStringAsFixed(2)}'),
      ],
    );
  }
}
