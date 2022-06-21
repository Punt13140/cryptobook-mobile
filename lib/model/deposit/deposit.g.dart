// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deposit _$DepositFromJson(Map<String, dynamic> json) => Deposit(
      json['id'] as int,
      DateTime.parse(json['depositedAt'] as String),
      json['valueEur'] as int,
    );

Map<String, dynamic> _$DepositToJson(Deposit instance) => <String, dynamic>{
      'id': instance.id,
      'depositedAt': instance.depositedAt.toIso8601String(),
      'valueEur': instance.valueEur,
    };
