import 'package:cryptobook/model/loan/loan.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_loan.g.dart';

@JsonSerializable()
class LoanList {
  @JsonKey(name: '@id')
  final String id;
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'hydra:member')
  final List<Loan> lstObjects;
  @JsonKey(name: 'hydra:totalItems')
  final int hydraTotalItems;

  LoanList(this.id, this.type, this.lstObjects, this.hydraTotalItems);

  factory LoanList.fromJson(Map<String, dynamic> json) => _$LoanListFromJson(json);

  Map<String, dynamic> toJson() => _$LoanListToJson(this);

  @override
  String toString() {
    return 'LoanList{id: $id, type: $type, hydraTotalItems: $hydraTotalItems}';
  }
}
