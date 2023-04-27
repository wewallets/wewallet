/// pledge_id : "2"
/// title : ""
/// title_en : ""
/// title_th : ""
/// title_ms : ""
/// intro : ""
/// intro_en : ""
/// intro_th : ""
/// intro_ms : ""
/// type : "1"
/// day : "100"
/// rate : "15.0000"
/// pay_currency : "YISE"
/// pay_totaled : "0.00000000"
/// pay_min : "1.00000000"
/// pay_max : "10000.00000000"
/// to_currency : "YISE"
/// to_totaled : "0.00000000"
/// to_team_totaled : "0.00000000"
/// create_time : "2023-02-19 12:48:38"
/// is_on_sale : "1"
/// expire_fee : "0.0000"

class WalletPledgeList {
  WalletPledgeList({
      String pledgeId, 
      String title, 
      String titleEn, 
      String titleTh, 
      String titleMs, 
      String intro, 
      String introEn, 
      String introTh, 
      String introMs, 
      String type, 
      String day, 
      String rate, 
      String payCurrency, 
      String payTotaled, 
      String payMin, 
      String payMax, 
      String toCurrency, 
      String toTotaled, 
      String toTeamTotaled, 
      String createTime, 
      String isOnSale, 
      String expireFee,}){
    _pledgeId = pledgeId;
    _title = title;
    _titleEn = titleEn;
    _titleTh = titleTh;
    _titleMs = titleMs;
    _intro = intro;
    _introEn = introEn;
    _introTh = introTh;
    _introMs = introMs;
    _type = type;
    _day = day;
    _rate = rate;
    _payCurrency = payCurrency;
    _payTotaled = payTotaled;
    _payMin = payMin;
    _payMax = payMax;
    _toCurrency = toCurrency;
    _toTotaled = toTotaled;
    _toTeamTotaled = toTeamTotaled;
    _createTime = createTime;
    _isOnSale = isOnSale;
    _expireFee = expireFee;
}

  WalletPledgeList.fromJson(dynamic json) {
    _pledgeId = json['pledge_id'];
    _title = json['title'];
    _titleEn = json['title_en'];
    _titleTh = json['title_th'];
    _titleMs = json['title_ms'];
    _intro = json['intro'];
    _introEn = json['intro_en'];
    _introTh = json['intro_th'];
    _introMs = json['intro_ms'];
    _type = json['type'];
    _day = json['day'];
    _rate = json['rate'];
    _payCurrency = json['pay_currency'];
    _payTotaled = json['pay_totaled'];
    _payMin = json['pay_min'];
    _payMax = json['pay_max'];
    _toCurrency = json['to_currency'];
    _toTotaled = json['to_totaled'];
    _toTeamTotaled = json['to_team_totaled'];
    _createTime = json['create_time'];
    _isOnSale = json['is_on_sale'];
    _expireFee = json['expire_fee'];
  }
  String _pledgeId;
  String _title;
  String _titleEn;
  String _titleTh;
  String _titleMs;
  String _intro;
  String _introEn;
  String _introTh;
  String _introMs;
  String _type;
  String _day;
  String _rate;
  String _payCurrency;
  String _payTotaled;
  String _payMin;
  String _payMax;
  String _toCurrency;
  String _toTotaled;
  String _toTeamTotaled;
  String _createTime;
  String _isOnSale;
  String _expireFee;
WalletPledgeList copyWith({  String pledgeId,
  String title,
  String titleEn,
  String titleTh,
  String titleMs,
  String intro,
  String introEn,
  String introTh,
  String introMs,
  String type,
  String day,
  String rate,
  String payCurrency,
  String payTotaled,
  String payMin,
  String payMax,
  String toCurrency,
  String toTotaled,
  String toTeamTotaled,
  String createTime,
  String isOnSale,
  String expireFee,
}) => WalletPledgeList(  pledgeId: pledgeId ?? _pledgeId,
  title: title ?? _title,
  titleEn: titleEn ?? _titleEn,
  titleTh: titleTh ?? _titleTh,
  titleMs: titleMs ?? _titleMs,
  intro: intro ?? _intro,
  introEn: introEn ?? _introEn,
  introTh: introTh ?? _introTh,
  introMs: introMs ?? _introMs,
  type: type ?? _type,
  day: day ?? _day,
  rate: rate ?? _rate,
  payCurrency: payCurrency ?? _payCurrency,
  payTotaled: payTotaled ?? _payTotaled,
  payMin: payMin ?? _payMin,
  payMax: payMax ?? _payMax,
  toCurrency: toCurrency ?? _toCurrency,
  toTotaled: toTotaled ?? _toTotaled,
  toTeamTotaled: toTeamTotaled ?? _toTeamTotaled,
  createTime: createTime ?? _createTime,
  isOnSale: isOnSale ?? _isOnSale,
  expireFee: expireFee ?? _expireFee,
);
  String get pledgeId => _pledgeId;
  String get title => _title;
  String get titleEn => _titleEn;
  String get titleTh => _titleTh;
  String get titleMs => _titleMs;
  String get intro => _intro;
  String get introEn => _introEn;
  String get introTh => _introTh;
  String get introMs => _introMs;
  String get type => _type;
  String get day => _day;
  String get rate => _rate;
  String get payCurrency => _payCurrency;
  String get payTotaled => _payTotaled;
  String get payMin => _payMin;
  String get payMax => _payMax;
  String get toCurrency => _toCurrency;
  String get toTotaled => _toTotaled;
  String get toTeamTotaled => _toTeamTotaled;
  String get createTime => _createTime;
  String get isOnSale => _isOnSale;
  String get expireFee => _expireFee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pledge_id'] = _pledgeId;
    map['title'] = _title;
    map['title_en'] = _titleEn;
    map['title_th'] = _titleTh;
    map['title_ms'] = _titleMs;
    map['intro'] = _intro;
    map['intro_en'] = _introEn;
    map['intro_th'] = _introTh;
    map['intro_ms'] = _introMs;
    map['type'] = _type;
    map['day'] = _day;
    map['rate'] = _rate;
    map['pay_currency'] = _payCurrency;
    map['pay_totaled'] = _payTotaled;
    map['pay_min'] = _payMin;
    map['pay_max'] = _payMax;
    map['to_currency'] = _toCurrency;
    map['to_totaled'] = _toTotaled;
    map['to_team_totaled'] = _toTeamTotaled;
    map['create_time'] = _createTime;
    map['is_on_sale'] = _isOnSale;
    map['expire_fee'] = _expireFee;
    return map;
  }

}