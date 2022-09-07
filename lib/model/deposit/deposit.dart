import 'package:json_annotation/json_annotation.dart';

part 'deposit.g.dart';

@JsonSerializable()
class Deposit {
  final int id;
  final DateTime depositedAt;
  //final TypeDeposit type;
  //final Exchange exchange;
  final double valueEur;

  Deposit(this.id, this.depositedAt, this.valueEur);

  factory Deposit.fromJson(Map<String, dynamic> json) => _$DepositFromJson(json);

  Map<String, dynamic> toJson() => _$DepositToJson(this);
}
