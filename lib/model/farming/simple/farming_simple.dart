import 'package:cryptobook/model/cryptocurrency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'farming_simple.g.dart';

@JsonSerializable()
class FarmingSimple {
  FarmingSimple({
    required this.id,
    required this.coin,
    required this.nbCoins,
    //this.dapp,
    required this.apr,
    required this.enteredAt,
    required this.description,
  });

  final int id;
  final Cryptocurrency coin;
  final double nbCoins;
  //final Dapp dapp;
  final double apr;
  final DateTime enteredAt;
  final String description;

  factory FarmingSimple.fromJson(Map<String, dynamic> json) => _$FarmingSimpleFromJson(json);

  Map<String, dynamic> toJson() => _$FarmingSimpleToJson(this);

  double get currentValue {
    return coin.priceUsd * nbCoins;
  }

  double get annualRewards {
    return currentValue * apr / 100;
  }

  @override
  String toString() {
    return 'FarmingSimple{id: $id, coin: ${coin.symbol}, nbCoins: $nbCoins, apr: $apr, enteredAt: $enteredAt}';
  }
}
