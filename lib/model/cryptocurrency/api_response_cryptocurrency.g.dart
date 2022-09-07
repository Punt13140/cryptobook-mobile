// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_cryptocurrency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptocurrencyList _$CryptocurrencyListFromJson(Map<String, dynamic> json) =>
    CryptocurrencyList(
      json['@id'] as String,
      json['@type'] as String,
      (json['hydra:member'] as List<dynamic>)
          .map((e) => Cryptocurrency.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hydra:totalItems'] as int,
    );

Map<String, dynamic> _$CryptocurrencyListToJson(CryptocurrencyList instance) =>
    <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'hydra:member': instance.lstObjects,
      'hydra:totalItems': instance.hydraTotalItems,
    };
