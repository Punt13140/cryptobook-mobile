// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cryptocurrency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cryptocurrency _$CryptocurrencyFromJson(Map<String, dynamic> json) =>
    Cryptocurrency(
      json['id'] as int,
      json['libelle'] as String,
      (json['priceUsd'] as num).toDouble(),
      json['urlImgThumb'] as String,
      json['symbol'] as String,
      json['isStable'] as bool,
      json['color'] as String?,
    );

Map<String, dynamic> _$CryptocurrencyToJson(Cryptocurrency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'libelle': instance.libelle,
      'priceUsd': instance.priceUsd,
      'urlImgThumb': instance.urlImgThumb,
      'symbol': instance.symbol,
      'isStable': instance.isStable,
      'color': instance.color,
    };
