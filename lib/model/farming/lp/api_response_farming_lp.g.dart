// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_farming_lp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmingLpList _$FarmingLpListFromJson(Map<String, dynamic> json) =>
    FarmingLpList(
      json['@id'] as String,
      json['@type'] as String,
      (json['hydra:member'] as List<dynamic>)
          .map((e) => FarmingLp.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hydra:totalItems'] as int,
    );

Map<String, dynamic> _$FarmingLpListToJson(FarmingLpList instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'hydra:member': instance.lstObjects,
      'hydra:totalItems': instance.hydraTotalItems,
    };
