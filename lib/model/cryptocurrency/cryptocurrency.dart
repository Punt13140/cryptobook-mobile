import 'package:flutter_awesome_select/flutter_awesome_select.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cryptocurrency.g.dart';

@JsonSerializable()
class Cryptocurrency {
  final int id;
  final String libelle;
  final double priceUsd;
  final String urlImgThumb;
  final String symbol;
  final bool isStable;
  final String? color;

  Cryptocurrency(
    this.id,
    this.libelle,
    this.priceUsd,
    this.urlImgThumb,
    this.symbol,
    this.isStable,
    this.color,
  );

  factory Cryptocurrency.fromJson(Map<String, dynamic> json) => _$CryptocurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CryptocurrencyToJson(this);

  @override
  String toString() {
    return 'Cryptocurrency{id: $id, priceUsd: $priceUsd, symbol: $symbol}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Cryptocurrency && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  static List<S2Choice<Cryptocurrency>> buildListChoice(List<Cryptocurrency> cryptocurrencies) {
    return cryptocurrencies.map((e) => S2Choice<Cryptocurrency>(value: e, title: e.libelle)).toList();
  }
}
