// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offerCreate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferCreate _$OfferCreateFromJson(Map<String, dynamic> json) {
  return OfferCreate()
    ..TransactionType = json['TransactionType'] as String
    ..Account = json['Account'] as String
    ..Fee = json['Fee'] as String
    ..Flags = json['Flags'] as num
    ..LastLedgerSequence = json['LastLedgerSequence'] as num
    ..Sequence = json['Sequence'] as num
    ..TakerGets = json['TakerGets'] as String
    ..TakerPays = json['TakerPays'] as Map<String, dynamic>;
}

Map<String, dynamic> _$OfferCreateToJson(OfferCreate instance) =>
    <String, dynamic>{
      'TransactionType': instance.TransactionType,
      'Account': instance.Account,
      'Fee': instance.Fee,
      'Flags': instance.Flags,
      'LastLedgerSequence': instance.LastLedgerSequence,
      'Sequence': instance.Sequence,
      'TakerGets': instance.TakerGets,
      'TakerPays': instance.TakerPays
    };
