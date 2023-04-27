class OredetailBean {
  int code;
  String msg;
  OredetailData data;

  OredetailBean({this.code, this.msg, this.data});

  OredetailBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new OredetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class OredetailData {
  String currencyName;
  String totleIncome;
  String bestKeepCoin;
  String minKeepCoin;
  String coinPower;
  String generaPower;
  String lastdayIncome;
  String totleIncomeCny;
  String coinPowerCny;
  String generaPowerCny;
  String totleWholeNetwork;
  List<LogList> logList;

  OredetailData({this.currencyName, this.totleIncome, this.bestKeepCoin, this.minKeepCoin, this.coinPower, this.generaPower, this.lastdayIncome, this.totleIncomeCny, this.coinPowerCny, this.generaPowerCny, this.logList});

  OredetailData.fromJson(Map<String, dynamic> json) {
    currencyName = json['currency_name'];
    totleWholeNetwork = json['totle_whole_network'];
    totleIncome = json['totle_income'];
    bestKeepCoin = json['best_keep_coin'];
    minKeepCoin = json['min_keep_coin'];
    coinPower = json['coin_power'];
    generaPower = json['genera_power'];
    lastdayIncome = json['lastday_income'];
    totleIncomeCny = json['totle_income_cny'];
    coinPowerCny = json['coin_power_cny'];
    generaPowerCny = json['genera_power_cny'];
    if (json['log_list'] != null) {
      logList = new List<LogList>();
      json['log_list'].forEach((v) {
        logList.add(new LogList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency_name'] = this.currencyName;
    data['totle_income'] = this.totleIncome;
    data['best_keep_coin'] = this.bestKeepCoin;
    data['min_keep_coin'] = this.minKeepCoin;
    data['coin_power'] = this.coinPower;
    data['genera_power'] = this.generaPower;
    data['lastday_income'] = this.lastdayIncome;
    data['totle_income_cny'] = this.totleIncomeCny;
    data['coin_power_cny'] = this.coinPowerCny;
    data['genera_power_cny'] = this.generaPowerCny;
    if (this.logList != null) {
      data['log_list'] = this.logList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LogList {
  String date;
  String incomeCny;

  LogList({this.date, this.incomeCny});

  LogList.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    incomeCny = json['income_cny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['income_cny'] = this.incomeCny;
    return data;
  }
}
