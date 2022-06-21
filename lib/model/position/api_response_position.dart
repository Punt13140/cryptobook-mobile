import 'package:cryptobook/model/position/position.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response_position.g.dart';

@JsonSerializable()
class PositionList {
  @JsonKey(name: '@id')
  final String id;
  @JsonKey(name: '@type')
  final String type;
  @JsonKey(name: 'hydra:member')
  final List<Position> lstObjects;
  @JsonKey(name: 'hydra:totalItems')
  final int hydraTotalItems;

  PositionList(this.id, this.type, this.lstObjects, this.hydraTotalItems);

  factory PositionList.fromJson(Map<String, dynamic> json) => _$PositionListFromJson(json);

  Map<String, dynamic> toJson() => _$PositionListToJson(this);

  @override
  String toString() {
    return 'PositionList{id: $id, type: $type, hydraTotalItems: $hydraTotalItems}';
  }
}
