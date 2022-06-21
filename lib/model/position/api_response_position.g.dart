// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionList _$PositionListFromJson(Map<String, dynamic> json) => PositionList(
      json['@id'] as String,
      json['@type'] as String,
      (json['hydra:member'] as List<dynamic>)
          .map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hydra:totalItems'] as int,
    );

Map<String, dynamic> _$PositionListToJson(PositionList instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'hydra:member': instance.lstObjects,
      'hydra:totalItems': instance.hydraTotalItems,
    };
