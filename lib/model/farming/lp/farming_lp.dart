import 'package:cryptobook/model/cryptocurrency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'farming_lp.g.dart';

@JsonSerializable()
class FarmingLp {
  FarmingLp({
    required this.id,
    required this.coin1,
    required this.coin2,
    //this.dapp,
    required this.startAt,
    required this.priceCoin1,
    required this.priceCoin2,
    required this.nbCoin1,
    required this.nbCoin2,
    required this.apr,
    required this.description,
    this.lpDeposit,
  });

  final int id;
  final Cryptocurrency coin1;
  final Cryptocurrency coin2;
//  final Dapp dapp;
  final DateTime startAt;
  final double priceCoin1;
  final double priceCoin2;
  final double nbCoin1;
  final double nbCoin2;
  final double? lpDeposit;
  final double apr;
  final String description;

  factory FarmingLp.fromJson(Map<String, dynamic> json) => _$FarmingLpFromJson(json);

  Map<String, dynamic> toJson() => _$FarmingLpToJson(this);

  double get currentValueCoin1 {
    return coin1.priceUsd * nbCoin1;
  }

  double get currentValueCoin2 {
    return coin2.priceUsd * nbCoin2;
  }

  double get currentValueTotal {
    return currentValueCoin1 + currentValueCoin2;
  }

  double get annualRewards {
    return currentValueTotal * apr / 100;
  }

  @override
  String toString() {
    return 'FarmingLp{id: $id, coin1: ${coin1.symbol}, coin2: ${coin2.symbol}, nbCoin1: $nbCoin1, nbCoin2: $nbCoin2, apr: $apr}';
  }
}
