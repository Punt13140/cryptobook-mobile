import 'package:cryptobook/model/farming/lp/farming_lp.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_farming_lp.g.dart';

@JsonSerializable()
class FarmingLpList {
  @JsonKey(name: '@id')
  final String id;
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'hydra:member')
  final List<FarmingLp> lstObjects;
  @JsonKey(name: 'hydra:totalItems')
  final int hydraTotalItems;

  FarmingLpList(this.id, this.type, this.lstObjects, this.hydraTotalItems);

  factory FarmingLpList.fromJson(Map<String, dynamic> json) => _$FarmingLpListFromJson(json);

  Map<String, dynamic> toJson() => _$FarmingLpListToJson(this);

  @override
  String toString() {
    return 'FarmingLpList{id: $id, type: $type, hydraTotalItems: $hydraTotalItems}';
  }
}
