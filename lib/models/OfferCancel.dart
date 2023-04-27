import 'package:json_annotation/json_annotation.dart';

part 'OfferCancel.g.dart';

@JsonSerializable()
class OfferCancel {
    OfferCancel();

    String TransactionType;
    String Account;
    String Fee;
    num Flags;
    num LastLedgerSequence;
    num OfferSequence;
    num Sequence;
    
    factory OfferCancel.fromJson(Map<String,dynamic> json) => _$OfferCancelFromJson(json);
    Map<String, dynamic> toJson() => _$OfferCancelToJson(this);
}
