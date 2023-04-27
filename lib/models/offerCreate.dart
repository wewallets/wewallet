import 'package:json_annotation/json_annotation.dart';

part 'offerCreate.g.dart';

@JsonSerializable()
class OfferCreate {
    OfferCreate();

    String TransactionType;
    String Account;
    String Fee;
    num Flags;
    num LastLedgerSequence;
    num Sequence;
    String TakerGets;
    Map<String,dynamic> TakerPays;
    
    factory OfferCreate.fromJson(Map<String,dynamic> json) => _$OfferCreateFromJson(json);
    Map<String, dynamic> toJson() => _$OfferCreateToJson(this);
}
