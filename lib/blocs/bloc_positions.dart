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
  final List<Position> lstPosCryptoOpened;
  final List<Position> lstPosStableOpened;
  final List<Position> lstPosClosed;

  PositionsBlocState({
    required this.lstPosCryptoOpened,
    required this.lstPosStableOpened,
    required this.lstPosClosed,
  });

  const PositionsBlocState.initial()
      : lstPosCryptoOpened = const [],
        lstPosStableOpened = const [],
        lstPosClosed = const [];
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
      lstPosCryptoOpened: lstPosCryptoOpened,
      lstPosClosed: lstPosClosed,
      lstPosStableOpened: lstPosStableOpened,
    ));
  }
}
