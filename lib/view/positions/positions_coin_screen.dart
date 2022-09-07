import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/util.dart';
import 'package:cryptobook/utils/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PositionsByCoin extends StatelessWidget {
  const PositionsByCoin({Key? key, required this.positions, required this.coin}) : super(key: key);
  final List<Position> positions;
  final Cryptocurrency coin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(coin.libelle),
        ),
        body: ListViewPositions(
          positions: positions,
        ),
        bottomNavigationBar: const BottomBar(
          position: 1,
        ));
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
                  '${nbCoinsFormated(positions[index].remainingCoins)} ${positions[index].coin.symbol.toUpperCase()}'),
              subtitle: Text('~ \$${positions[index].currentValue.toStringAsFixed(0)}'),
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

class PositionDialogContent extends StatelessWidget {
  const PositionDialogContent({Key? key, required this.position}) : super(key: key);
  final Position position;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${nbCoinsFormated(position.remainingCoins)} ${position.coin.symbol.toUpperCase()}'),
      content: ContentDialog(
        position: position,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class ContentDialog extends StatelessWidget {
  const ContentDialog({Key? key, required this.position}) : super(key: key);
  final Position position;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListBody(
        children: [
          Text('Ouverte le ${DateFormat.yMd().format(position.openedAt)}'),
          Text('Nombre acheté ${position.nbCoins.toString()}'),
          if (position.nbCoins != position.remainingCoins) Text('Nombre restant ${position.remainingCoins.toString()}'),
          Text('Valeur actuelle \$${position.currentValue.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
