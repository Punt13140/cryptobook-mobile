import 'package:cryptobook/model/farming/simple/farming_simple.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_farming_simple.g.dart';

@JsonSerializable()
class FarmingSimpleList {
  @JsonKey(name: '@id')
  final String id;
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'hydra:member')
  final List<FarmingSimple> lstObjects;
  @JsonKey(name: 'hydra:totalItems')
  final int hydraTotalItems;

  FarmingSimpleList(this.id, this.type, this.lstObjects, this.hydraTotalItems);

  factory FarmingSimpleList.fromJson(Map<String, dynamic> json) => _$FarmingSimpleListFromJson(json);

  Map<String, dynamic> toJson() => _$FarmingSimpleListToJson(this);

  @override
  String toString() {
    return 'FarmingSimpleList{id: $id, type: $type, hydraTotalItems: $hydraTotalItems}';
  }
}
