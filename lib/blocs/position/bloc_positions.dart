import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PositionsBlocEvent {
  const PositionsBlocEvent();
}

class LoadPositionsEvent extends PositionsBlocEvent {
  const LoadPositionsEvent();
}

class PositionsBlocState {
  final Map<Cryptocurrency, Map<String, dynamic>> groupedPosCryptoOpened;
  final Map<Cryptocurrency, Map<String, dynamic>> groupedPosStableOpened;
  final Map<Cryptocurrency, Map<String, dynamic>> groupedPosClosed;

  PositionsBlocState({
    required this.groupedPosCryptoOpened,
    required this.groupedPosStableOpened,
    required this.groupedPosClosed,
  });

  const PositionsBlocState.initial()
      : groupedPosCryptoOpened = const {},
        groupedPosStableOpened = const {},
        groupedPosClosed = const {};
}

class PositionsBloc extends Bloc<PositionsBlocEvent, PositionsBlocState> {
  PositionsBloc() : super(const PositionsBlocState.initial()) {
    on<LoadPositionsEvent>(loadPositions);

    add(const LoadPositionsEvent());
  }

  void loadPositions(LoadPositionsEvent event, Emitter<PositionsBlocState> emit) async {
    List<Position> positions = await NetworkManager().getPositions();

    //Positions =>
    List<Position> lstPosCryptoOpened =
        positions.where((element) => (element.isOpened && !element.coin.isStable)).toList();
    List<Position> lstPosClosed = positions.where((element) => !element.isOpened).toList();
    List<Position> lstPosStableOpened =
        positions.where((element) => (element.isOpened && element.coin.isStable)).toList();

    //await Future.delayed(const Duration(seconds: 5));

    emit(PositionsBlocState(
        groupedPosCryptoOpened: regroupPositions(lstPosCryptoOpened),
        groupedPosStableOpened: regroupPositions(lstPosStableOpened),
        groupedPosClosed: regroupPositions(lstPosClosed)));
  }

  Map<Cryptocurrency, Map<String, dynamic>> regroupPositions(List<Position> positions) {
    Map<Cryptocurrency, Map<String, dynamic>> map = {};

    for (var element in positions) {
      if (map.containsKey(element.coin)) {
        //map[element.coin] = map[element.coin]! + element.currentValue;
        map[element.coin]!['nbTotal'] += element.remainingCoins;
        map[element.coin]!['nbPositions']++;
        map[element.coin]!['positions'].add(element);
      } else {
        map[element.coin] = {
          'nbTotal': element.remainingCoins,
          'nbPositions': 1,
          'positions': [element]
        };
      }
    }

    return map;
  }
}
