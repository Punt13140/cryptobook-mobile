import 'package:cryptobook/model/farming/lp/farming_lp.dart';
import 'package:cryptobook/model/farming/simple/farming_simple.dart';
import 'package:cryptobook/utils/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class FarmingsBlocEvent {
  const FarmingsBlocEvent();
}

class LoadFarmingsEvent extends FarmingsBlocEvent {
  const LoadFarmingsEvent();
}

class FarmingsBlocState {
  final List<FarmingSimple> simpleFarmings;
  final List<FarmingSimple> stableFarmings;
  final List<FarmingLp> lpFarmings;

  FarmingsBlocState({
    required this.simpleFarmings,
    required this.stableFarmings,
    required this.lpFarmings,
  });

  const FarmingsBlocState.initial()
      : simpleFarmings = const [],
        stableFarmings = const [],
        lpFarmings = const [];
}

class FarmingsBloc extends Bloc<FarmingsBlocEvent, FarmingsBlocState> {
  FarmingsBloc() : super(const FarmingsBlocState.initial()) {
    on<LoadFarmingsEvent>(loadFarmings);

    add(const LoadFarmingsEvent());
  }

  void loadFarmings(LoadFarmingsEvent event, Emitter<FarmingsBlocState> emit) async {
    List<FarmingSimple> farmings = await NetworkManager().getSimpleFarmings();
    List<FarmingLp> lps = await NetworkManager().getLpFarmings();

    List<FarmingSimple> lstFarmingSimple = farmings.where((element) => !element.coin.isStable).toList();
    List<FarmingSimple> lstFarmingStable = farmings.where((element) => element.coin.isStable).toList();

    emit(FarmingsBlocState(
      simpleFarmings: lstFarmingSimple,
      stableFarmings: lstFarmingStable,
      lpFarmings: lps,
    ));
    // emit(PositionsBlocState(
    //     groupedPosCryptoOpened: regroupPositions(lstPosCryptoOpened),
    //     groupedPosStableOpened: regroupPositions(lstPosStableOpened),
    //     groupedPosClosed: regroupPositions(lstPosClosed)));
  }
}
