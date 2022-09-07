import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'position.g.dart';

@JsonSerializable()
class Position {
  final int? id;
  final double nbCoins;
  final Cryptocurrency coin;
  final bool isOpened;
  final double entryCost;
  final DateTime openedAt;
  final double remainingCoins;
  final String description;
  final double currentValue;

  Position(
    this.id,
    this.nbCoins,
    this.coin,
    this.isOpened,
    this.entryCost,
    this.openedAt,
    this.remainingCoins,
    this.description,
    this.currentValue,
  );

  factory Position.fromJson(Map<String, dynamic> json) => _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);

  @override
  String toString() {
    return 'Position{id: $id, nbCoins: $nbCoins, coin: $coin, isOpened: $isOpened, openedAt: $openedAt, currentValue: $currentValue}';
  }
}
