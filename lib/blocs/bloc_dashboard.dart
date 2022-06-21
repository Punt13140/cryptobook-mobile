import 'package:collection/collection.dart';
import 'package:cryptobook/model/cryptocurrency.dart';
import 'package:cryptobook/model/deposit/deposit.dart';
import 'package:cryptobook/model/loan/loan.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DashboardBlocEvent {
  const DashboardBlocEvent();
}

class LoadDashboardEvent extends DashboardBlocEvent {
  const LoadDashboardEvent();
}

class DashboardBlocState {
  final List<Position> positions;
  final double crypto;
  final double stable;
  final double invested;
  final double loan;
  final double total;
  final int percentWinLose;
  final Map<Cryptocurrency, double> mapChartCrypto;
  final Map<Cryptocurrency, double> mapChartStable;

  DashboardBlocState({
    required this.positions,
    required this.crypto,
    required this.stable,
    required this.invested,
    required this.loan,
    required this.total,
    required this.percentWinLose,
    required this.mapChartCrypto,
    required this.mapChartStable,
  });

  const DashboardBlocState.initial()
      : positions = const [],
        crypto = 0.0,
        stable = 0.0,
        invested = 0.0,
        loan = 0.0,
        total = 0.0,
        percentWinLose = 0,
        mapChartCrypto = const {},
        mapChartStable = const {};
}

class DashboardBloc extends Bloc<DashboardBlocEvent, DashboardBlocState> {
  DashboardBloc() : super(const DashboardBlocState.initial()) {
    on<LoadDashboardEvent>(loadDashboard);

    add(const LoadDashboardEvent());
  }

  void loadDashboard(LoadDashboardEvent event, Emitter<DashboardBlocState> emit) async {
    List<Position> positions = await NetworkManager().getPositions();
    List<Loan> loans = await NetworkManager().getLoans();
    List<Deposit> deposits = await NetworkManager().getDeposits();

    //Positions =>
    List<Position> lstOpenedCrypto =
        positions.where((element) => (element.isOpened && !element.coin.isStable)).toList();
    List<Position> lstOpenedStable = positions.where((element) => (element.isOpened && element.coin.isStable)).toList();
    double crypto = lstOpenedCrypto.map((e) => e.currentValue).sum;
    double stable = lstOpenedStable.map((e) => e.currentValue).sum;
    double total = crypto + stable;

    //Loans =>
    double loansValue = loans.map((e) => e.currentValue).sum;

    //Deposits =>
    double depositsValue = deposits.map((e) => e.valueEur.toDouble()).sum;
    // TODO : Cette valeur est en Euro et fausse le calcul de pourcentage.

    //Percents =>
    double percentWinLose = (total * 100 / depositsValue) - 100.0;

    //Charts =>
    Map<Cryptocurrency, double> mapChartCrypto = generateMapForChart(lstOpenedCrypto);
    Map<Cryptocurrency, double> mapChartStable = generateMapForChart(lstOpenedStable);

    //await Future.delayed(const Duration(seconds: 5));

    emit(DashboardBlocState(
        positions: positions,
        crypto: crypto,
        stable: stable,
        total: total,
        invested: depositsValue,
        loan: loansValue,
        percentWinLose: percentWinLose.toInt(),
        mapChartCrypto: mapChartCrypto,
        mapChartStable: mapChartStable));
  }

  Map<Cryptocurrency, double> generateMapForChart(List<Position> lstPosCryptoOpened) {
    Map<Cryptocurrency, double> map = {};

    for (var element in lstPosCryptoOpened) {
      if (map.containsKey(element.coin)) {
        map[element.coin] = map[element.coin]! + element.currentValue;
      } else {
        map[element.coin] = element.currentValue;
      }
    }

    return map;
  }
}
