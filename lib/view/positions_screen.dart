import 'package:cryptobook/blocs/bloc_positions.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/actions_list.dart';
import 'package:cryptobook/utils/widgets/bottom_bar.dart';
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Ajouter une position',
            child: const Icon(Icons.add),
          )),
    );
  }
}

class CryptoOpenedWidget extends StatelessWidget {
  const CryptoOpenedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PositionsBloc, PositionsBlocState>(
      buildWhen: (oldState, newState) => oldState.lstPosCryptoOpened.isEmpty,
      builder: (_, PositionsBlocState state) {
        if (state.lstPosCryptoOpened.isNotEmpty) {
          return ListViewPositions(positions: state.lstPosCryptoOpened);
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
      buildWhen: (oldState, newState) => oldState.lstPosStableOpened.isEmpty,
      builder: (_, PositionsBlocState state) {
        if (state.lstPosStableOpened.isNotEmpty) {
          return ListViewPositions(positions: state.lstPosStableOpened);
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
      buildWhen: (oldState, newState) => oldState.lstPosClosed.isEmpty,
      builder: (_, PositionsBlocState state) {
        if (state.lstPosClosed.isNotEmpty) {
          return ListViewPositions(positions: state.lstPosClosed);
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class ListViewPositions extends StatelessWidget {
  const ListViewPositions({Key? key, required this.positions}) : super(key: key);
  final List<Position> positions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemCount: positions.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onTap: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PositionDialogContent(position: positions[index]);
                    });
              },
              leading: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(positions[index].coin.urlImgThumb),
              ),
              title: Text(
                  '${positions[index].remainingCoins.toStringAsFixed(4)} ${positions[index].coin.symbol.toUpperCase()}'),
              subtitle: Text('~ \$${positions[index].currentValue.toStringAsFixed(0)}'),
              trailing: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: ActionsList.actionEdit,
                    child: Text("Modifier"),
                  ),
                  const PopupMenuItem(
                    value: ActionsList.actionClose,
                    child: Text("Fermer la position"),
                  ),
                  const PopupMenuItem(
                    value: ActionsList.actionDelete,
                    child: Text("Supprimer la position"),
                  )
                ],
              ),
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
