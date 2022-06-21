import 'package:cryptobook/model/cryptocurrency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'loan.g.dart';

@JsonSerializable()
class Loan {
  final int id;
  final Cryptocurrency coin;
  final double nbCoins;
  //final Dapp dapp;
  final String description;
  final DateTime loanedAt;
  final double currentValue;

  Loan(this.id, this.coin, this.nbCoins, this.description, this.loanedAt, this.currentValue);

  factory Loan.fromJson(Map<String, dynamic> json) => _$LoanFromJson(json);

  Map<String, dynamic> toJson() => _$LoanToJson(this);
}
