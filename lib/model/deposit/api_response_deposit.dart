import 'package:cryptobook/model/deposit/deposit.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_deposit.g.dart';

@JsonSerializable()
class DepositList {
  @JsonKey(name: '@id')
  final String id;
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'hydra:member')
  final List<Deposit> lstObjects;
  @JsonKey(name: 'hydra:totalItems')
  final int hydraTotalItems;

  DepositList(this.id, this.type, this.lstObjects, this.hydraTotalItems);

  factory DepositList.fromJson(Map<String, dynamic> json) => _$DepositListFromJson(json);

  Map<String, dynamic> toJson() => _$DepositListToJson(this);

  @override
  String toString() {
    return 'DepositList{id: $id, type: $type, hydraTotalItems: $hydraTotalItems}';
  }
}
