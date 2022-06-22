// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_farming_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmingSimpleList _$FarmingSimpleListFromJson(Map<String, dynamic> json) =>
    FarmingSimpleList(
      json['@id'] as String,
      json['@type'] as String,
      (json['hydra:member'] as List<dynamic>)
          .map((e) => FarmingSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hydra:totalItems'] as int,
    );

Map<String, dynamic> _$FarmingSimpleListToJson(FarmingSimpleList instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'hydra:member': instance.lstObjects,
      'hydra:totalItems': instance.hydraTotalItems,
    };
