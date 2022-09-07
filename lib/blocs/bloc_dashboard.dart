import 'dart:collection';

import 'package:collection/collection.dart';
import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:cryptobook/model/deposit/deposit.dart';
import 'package:cryptobook/model/farming/lp/farming_lp.dart';
import 'package:cryptobook/model/farming/simple/farming_simple.dart';
import 'package:cryptobook/model/loan/loan.dart';
import 'package:cryptobook/model/position/position.dart';
import 'package:cryptobook/utils/api.dart';
import 'package:cryptobook/utils/view_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DashboardBlocEvent {
  const DashboardBlocEvent();
}

class LoadDashboardEvent extends DashboardBlocEvent {
  const LoadDashboardEvent();
}

class DashboardBlocState {
  final List<Position>? positions;
  final double? crypto;
  final double? stable;
  final double? invested;
  final double? loan;
  final double? total;
  final double? annualFarming;
  final int? percentWinLose;
  final Map<Cryptocurrency, double>? mapChartCrypto;
  final Map<Cryptocurrency, double>? mapChartStable;
  final ViewStatus status;

  const DashboardBlocState._({
    this.positions,
    this.crypto,
    this.stable,
    this.invested,
    this.loan,
    this.total,
    this.annualFarming,
    this.percentWinLose,
    this.mapChartCrypto,
    this.mapChartStable,
    this.status = ViewStatus.initial,
  });

  const DashboardBlocState.initial() : this._();

  DashboardBlocState copyWith({
    List<Position>? positions,
    double? crypto,
    double? stable,
    double? invested,
    double? loan,
    double? total,
    double? annualFarming,
    int? percentWinLose,
    Map<Cryptocurrency, double>? mapChartCrypto,
    Map<Cryptocurrency, double>? mapChartStable,
    ViewStatus? status,
  }) {
    return DashboardBlocState._(
      positions: positions ?? this.positions,
      crypto: crypto ?? this.crypto,
      stable: stable ?? this.stable,
      invested: invested ?? this.invested,
      loan: loan ?? this.loan,
      total: total ?? this.total,
      annualFarming: annualFarming ?? this.annualFarming,
      percentWinLose: percentWinLose ?? this.percentWinLose,
      mapChartCrypto: mapChartCrypto ?? this.mapChartCrypto,
      mapChartStable: mapChartStable ?? this.mapChartStable,
      status: status ?? this.status,
    );
  }
}

class DashboardBloc extends Bloc<DashboardBlocEvent, DashboardBlocState> {
  DashboardBloc() : super(const DashboardBlocState.initial()) {
    on<LoadDashboardEvent>(loadDashboard);

    add(const LoadDashboardEvent());
  }

  void loadDashboard(LoadDashboardEvent event, Emitter<DashboardBlocState> emit) async {
    emit(state.copyWith(status: ViewStatus.loading));
    await Future.delayed(const Duration(seconds: 1));

    //Positions =>
    List<Position> positions = await NetworkManager().getPositions();

    List<Position> lstOpenedCrypto =
        positions.where((element) => (element.isOpened && !element.coin.isStable)).toList();
    double crypto = lstOpenedCrypto.map((e) => e.currentValue).sum;
    emit(state.copyWith(crypto: crypto));
    await Future.delayed(const Duration(seconds: 1));

    List<Position> lstOpenedStable = positions.where((element) => (element.isOpened && element.coin.isStable)).toList();
    double stable = lstOpenedStable.map((e) => e.currentValue).sum;
    emit(state.copyWith(stable: stable));
    await Future.delayed(const Duration(seconds: 1));

    double total = crypto + stable;
    emit(state.copyWith(total: total));
    await Future.delayed(const Duration(seconds: 1));

    //Deposits =>
    List<Deposit> deposits = await NetworkManager().getDeposits();
    double depositsValueEur = deposits.map((e) => e.valueEur.toDouble()).sum;
    Cryptocurrency eurt = await NetworkManager().getCryptocurrency(87);
    double depositsValue = depositsValueEur * eurt.priceUsd;
    emit(state.copyWith(invested: depositsValue));
    await Future.delayed(const Duration(seconds: 1));

    //Loans =>
    List<Loan> loans = await NetworkManager().getLoans();
    double loansValue = loans.map((e) => e.currentValue).sum;
    emit(state.copyWith(loan: loansValue));
    await Future.delayed(const Duration(seconds: 1));

    //Percents =>
    double percentWinLose = (total * 100 / depositsValue) - 100.0;
    emit(state.copyWith(percentWinLose: percentWinLose.toInt()));
    await Future.delayed(const Duration(seconds: 1));

    //Farming =>
    List<FarmingSimple> farmings = await NetworkManager().getSimpleFarmings();
    List<FarmingLp> lps = await NetworkManager().getLpFarmings();
    double annualFarmingSimple = farmings.map((e) => e.annualRewards).sum;
    double annualFarmingLp = lps.map((e) => e.annualRewards).sum;
    emit(state.copyWith(annualFarming: (annualFarmingSimple + annualFarmingLp) / 12));
    await Future.delayed(const Duration(seconds: 1));

    //Charts =>
    Map<Cryptocurrency, double> mapChartCrypto = generateMapForChart(lstOpenedCrypto);
    emit(state.copyWith(mapChartCrypto: mapChartCrypto));
    await Future.delayed(const Duration(seconds: 1));

    Map<Cryptocurrency, double> mapChartStable = generateMapForChart(lstOpenedStable);
    emit(state.copyWith(mapChartStable: mapChartStable));
    await Future.delayed(const Duration(seconds: 1));

    emit(state.copyWith(status: ViewStatus.success));
  }

  Map<Cryptocurrency, double> generateMapForChart(List<Position> lstPosCryptoOpened) {
    Map<Cryptocurrency, double> map = {};

    double totalValue = 0.0;

    for (var element in lstPosCryptoOpened) {
      totalValue += element.currentValue;
      if (map.containsKey(element.coin)) {
        map[element.coin] = map[element.coin]! + element.currentValue;
      } else {
        map[element.coin] = element.currentValue;
      }
    }

    Map<Cryptocurrency, double> mapWithoutSmallValue = {};

    map.forEach((key, value) {
      if (value * 100.0 / totalValue > 1.0) {
        mapWithoutSmallValue[key] = value;
      }
    });

    var sortedKeys = mapWithoutSmallValue.keys.toList(growable: false)
      ..sort((k2, k1) => mapWithoutSmallValue[k1]!.compareTo(mapWithoutSmallValue[k2]!));
    return LinkedHashMap.fromIterable(sortedKeys, key: (k) => k, value: (k) => mapWithoutSmallValue[k]!);
  }
}
