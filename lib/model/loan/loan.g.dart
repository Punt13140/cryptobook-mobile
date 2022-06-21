// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Loan _$LoanFromJson(Map<String, dynamic> json) => Loan(
      json['id'] as int,
      Cryptocurrency.fromJson(json['coin'] as Map<String, dynamic>),
      (json['nbCoins'] as num).toDouble(),
      json['description'] as String,
      DateTime.parse(json['loanedAt'] as String),
      (json['currentValue'] as num).toDouble(),
    );

Map<String, dynamic> _$LoanToJson(Loan instance) => <String, dynamic>{
      'id': instance.id,
      'coin': instance.coin,
      'nbCoins': instance.nbCoins,
      'description': instance.description,
      'loanedAt': instance.loanedAt.toIso8601String(),
      'currentValue': instance.currentValue,
    };
