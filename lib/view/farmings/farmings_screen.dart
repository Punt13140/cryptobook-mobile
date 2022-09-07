import 'package:cryptobook/blocs/bloc_farmings.dart';
import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/model/farming/lp/farming_lp.dart';
import 'package:cryptobook/model/farming/simple/farming_simple.dart';
import 'package:cryptobook/utils/util.dart';
import 'package:cryptobook/utils/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmingsScreen extends StatelessWidget {
  const FarmingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Farmings'),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.currency_bitcoin)),
              Tab(icon: Icon(Icons.euro_symbol)),
              Tab(icon: Icon(Icons.spoke)),
            ])),
        body: BlocProvider<FarmingsBloc>(
          create: (_) => FarmingsBloc(),
          child: const TabBarView(
            children: [
              SimpleFarmingContent(),
              StableFarmingContent(),
              LpFarmingContent(),
            ],
          ),
        ),
        bottomNavigationBar: const BottomBar(
          position: 2,
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   tooltip: 'Ajouter une position',
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}

class SimpleFarmingContent extends StatelessWidget {
  const SimpleFarmingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmingsBloc, FarmingsBlocState>(
      buildWhen: (oldState, newState) => oldState.simpleFarmings.isEmpty,
      builder: (_, FarmingsBlocState state) {
        if (state.simpleFarmings.isNotEmpty) {
          return ListViewSimpleFarmings(
            farmings: state.simpleFarmings,
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class StableFarmingContent extends StatelessWidget {
  const StableFarmingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmingsBloc, FarmingsBlocState>(
      buildWhen: (oldState, newState) => oldState.stableFarmings.isEmpty,
      builder: (_, FarmingsBlocState state) {
        if (state.stableFarmings.isNotEmpty) {
          return ListViewSimpleFarmings(
            farmings: state.stableFarmings,
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class LpFarmingContent extends StatelessWidget {
  const LpFarmingContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmingsBloc, FarmingsBlocState>(
      buildWhen: (oldState, newState) => oldState.lpFarmings.isEmpty,
      builder: (_, FarmingsBlocState state) {
        if (state.lpFarmings.isNotEmpty) {
          return ListViewLpFarmings(
            farmings: state.lpFarmings,
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class LpStackIcon extends StatelessWidget {
  const LpStackIcon({Key? key, required this.coin1, required this.coin2}) : super(key: key);
  final Cryptocurrency coin1;
  final Cryptocurrency coin2;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 50,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(coin1.urlImgThumb),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(coin2.urlImgThumb),
            ),
          )
        ],
      ),
    );
  }
}

class ListViewSimpleFarmings extends StatelessWidget {
  const ListViewSimpleFarmings({Key? key, required this.farmings}) : super(key: key);
  final List<FarmingSimple> farmings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: farmings.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(farmings[index].coin.urlImgThumb),
              ),
              title: Text('${nbCoinsFormated(farmings[index].nbCoins)} ${farmings[index].coin.symbol.toUpperCase()}'),
              subtitle: Text('~ \$${farmings[index].annualRewards.toStringAsFixed(2)}/Y'),
              // trailing: PopupMenuButton(
              //   icon: const Icon(Icons.more_vert),
              //   itemBuilder: (context) => [
              //     const PopupMenuItem(
              //       value: ActionsList.actionEdit,
              //       child: Text("Modifier"),
              //     ),
              //     const PopupMenuItem(
              //       value: ActionsList.actionClose,
              //       child: Text("Fermer la position"),
              //     ),
              //     const PopupMenuItem(
              //       value: ActionsList.actionDelete,
              //       child: Text("Supprimer la position"),
              //     )
              //   ],
              // ),
            ),
          );
        },
      ),
    );
  }
}

class ListViewLpFarmings extends StatelessWidget {
  const ListViewLpFarmings({Key? key, required this.farmings}) : super(key: key);
  final List<FarmingLp> farmings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: farmings.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: LpStackIcon(coin1: farmings[index].coin1, coin2: farmings[index].coin2),
              title: Text(
                  '${nbCoinsFormated(farmings[index].nbCoin1)}/${nbCoinsFormated(farmings[index].nbCoin2)} ${farmings[index].coin1.symbol.toUpperCase()}/${farmings[index].coin2.symbol.toUpperCase()}'),
              subtitle: Text('~ \$${farmings[index].annualRewards.toStringAsFixed(2)}/Y'),
              // trailing: PopupMenuButton(
              //   icon: const Icon(Icons.more_vert),
              //   itemBuilder: (context) => [
              //     const PopupMenuItem(
              //       value: ActionsList.actionEdit,
              //       child: Text("Modifier"),
              //     ),
              //     const PopupMenuItem(
              //       value: ActionsList.actionClose,
              //       child: Text("Fermer la position"),
              //     ),
              //     const PopupMenuItem(
              //       value: ActionsList.actionDelete,
              //       child: Text("Supprimer la position"),
              //     )
              //   ],
              // ),
            ),
          );
        },
      ),
    );
  }
}
