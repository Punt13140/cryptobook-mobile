// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farming_simple.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FarmingSimple _$FarmingSimpleFromJson(Map<String, dynamic> json) =>
    FarmingSimple(
      id: json['id'] as int,
      coin: Cryptocurrency.fromJson(json['coin'] as Map<String, dynamic>),
      nbCoins: (json['nbCoins'] as num).toDouble(),
      apr: (json['apr'] as num).toDouble(),
      enteredAt: json['enteredAt'] == null
          ? null
          : DateTime.parse(json['enteredAt'] as String),
      description: json['description'] as String,
    );

Map<String, dynamic> _$FarmingSimpleToJson(FarmingSimple instance) =>
    <String, dynamic>{
      'id': instance.id,
      'coin': instance.coin,
      'nbCoins': instance.nbCoins,
      'apr': instance.apr,
      'enteredAt': instance.enteredAt?.toIso8601String(),
      'description': instance.description,
    };
