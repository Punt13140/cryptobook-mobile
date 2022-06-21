// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepositList _$DepositListFromJson(Map<String, dynamic> json) => DepositList(
      json['@id'] as String,
      json['@type'] as String,
      (json['hydra:member'] as List<dynamic>)
          .map((e) => Deposit.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hydra:totalItems'] as int,
    );

Map<String, dynamic> _$DepositListToJson(DepositList instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'hydra:member': instance.lstObjects,
      'hydra:totalItems': instance.hydraTotalItems,
    };
