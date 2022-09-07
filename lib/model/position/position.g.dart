// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
      json['id'] as int?,
      (json['nbCoins'] as num).toDouble(),
      Cryptocurrency.fromJson(json['coin'] as Map<String, dynamic>),
      json['isOpened'] as bool,
      (json['entryCost'] as num).toDouble(),
      DateTime.parse(json['openedAt'] as String),
      (json['remainingCoins'] as num).toDouble(),
      json['description'] as String,
      (json['currentValue'] as num).toDouble(),
    );

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'id': instance.id,
      'nbCoins': instance.nbCoins,
      'coin': instance.coin,
      'isOpened': instance.isOpened,
      'entryCost': instance.entryCost,
      'openedAt': instance.openedAt.toIso8601String(),
      'remainingCoins': instance.remainingCoins,
      'description': instance.description,
      'currentValue': instance.currentValue,
    };
