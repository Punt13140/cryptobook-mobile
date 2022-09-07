import 'package:cryptobook/model/cryptocurrency/cryptocurrency.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_cryptocurrency.g.dart';

@JsonSerializable()
class CryptocurrencyList {
  @JsonKey(name: '@id')
  final String id;
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'hydra:member')
  final List<Cryptocurrency> lstObjects;
  @JsonKey(name: 'hydra:totalItems')
  final int hydraTotalItems;

  CryptocurrencyList(this.id, this.type, this.lstObjects, this.hydraTotalItems);

  factory CryptocurrencyList.fromJson(Map<String, dynamic> json) => _$CryptocurrencyListFromJson(json);

  Map<String, dynamic> toJson() => _$CryptocurrencyListToJson(this);

  @override
  String toString() {
    return 'CryptocurrencyList{id: $id, type: $type, hydraTotalItems: $hydraTotalItems}';
  }
}
