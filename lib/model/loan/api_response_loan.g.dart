// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_loan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoanList _$LoanListFromJson(Map<String, dynamic> json) => LoanList(
      json['@id'] as String,
      json['@type'] as String,
      (json['hydra:member'] as List<dynamic>)
          .map((e) => Loan.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['hydra:totalItems'] as int,
    );

Map<String, dynamic> _$LoanListToJson(LoanList instance) => <String, dynamic>{
      '@id': instance.id,
      '@type': instance.type,
      'hydra:member': instance.lstObjects,
      'hydra:totalItems': instance.hydraTotalItems,
    };
