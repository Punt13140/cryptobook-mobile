// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farming_lp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmingLp _$FarmingLpFromJson(Map<String, dynamic> json) => FarmingLp(
      id: json['id'] as int,
      coin1: Cryptocurrency.fromJson(json['coin1'] as Map<String, dynamic>),
      coin2: Cryptocurrency.fromJson(json['coin2'] as Map<String, dynamic>),
      startAt: DateTime.parse(json['startAt'] as String),
      priceCoin1: (json['priceCoin1'] as num).toDouble(),
      priceCoin2: (json['priceCoin2'] as num).toDouble(),
      nbCoin1: (json['nbCoin1'] as num).toDouble(),
      nbCoin2: (json['nbCoin2'] as num).toDouble(),
      apr: (json['apr'] as num).toDouble(),
      description: json['description'] as String,
      lpDeposit: (json['lpDeposit'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$FarmingLpToJson(FarmingLp instance) => <String, dynamic>{
      'id': instance.id,
      'coin1': instance.coin1,
      'coin2': instance.coin2,
      'startAt': instance.startAt.toIso8601String(),
      'priceCoin1': instance.priceCoin1,
      'priceCoin2': instance.priceCoin2,
      'nbCoin1': instance.nbCoin1,
      'nbCoin2': instance.nbCoin2,
      'lpDeposit': instance.lpDeposit,
      'apr': instance.apr,
      'description': instance.description,
    };
