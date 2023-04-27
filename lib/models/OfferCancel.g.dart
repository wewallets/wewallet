// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OfferCancel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferCancel _$OfferCancelFromJson(Map<String, dynamic> json) {
  return OfferCancel()
    ..TransactionType = json['TransactionType'] as String
    ..Account = json['Account'] as String
    ..Fee = json['Fee'] as String
    ..Flags = json['Flags'] as num
    ..LastLedgerSequence = json['LastLedgerSequence'] as num
    ..OfferSequence = json['OfferSequence'] as num
    ..Sequence = json['Sequence'] as num;
}

Map<String, dynamic> _$OfferCancelToJson(OfferCancel instance) =>
    <String, dynamic>{
      'TransactionType': instance.TransactionType,
      'Account': instance.Account,
      'Fee': instance.Fee,
      'Flags': instance.Flags,
      'LastLedgerSequence': instance.LastLedgerSequence,
      'OfferSequence': instance.OfferSequence,
      'Sequence': instance.Sequence
    };
