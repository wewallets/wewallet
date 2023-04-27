class OreBean {
  String currencyName;
  String totleIncome;
  String bestKeepCoin;
  String minKeepCoin;
  String coinPower;
  String generaPower;
  String lastdayIncome;
  String coinPowerCny;
  String totleIncomeCny;
  String generaPowerCny;
  String lastdayIncomeCny;
  String icon;

  OreBean({
    this.currencyName,
    this.totleIncome,
    this.bestKeepCoin,
    this.minKeepCoin,
    this.coinPower,
    this.generaPower,
    this.lastdayIncome,
    this.coinPowerCny,
    this.totleIncomeCny,
    this.generaPowerCny,
    this.lastdayIncomeCny,
  });

  OreBean.fromJson(Map<String, dynamic> json) {
    currencyName = json['net_currency_name'].toString();
    totleIncome = json['totle_income'].toString();
    icon = json['icon'].toString();
    bestKeepCoin = json['best_keep_coin'].toString();
    minKeepCoin = json['min_keep_coin'].toString();
    coinPower = json['coin_power'].toString();
    generaPower = json['genera_power'].toString();
    lastdayIncome = json['lastday_income'].toString();
    totleIncomeCny = json['totle_income_cny'].toString();
    coinPowerCny = json['coin_power_cny'].toString();
    generaPowerCny = json['genera_power_cny'].toString();
    lastdayIncomeCny = json['lastday_income_cny'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['net_currency_name'] = this.currencyName;
    data['totle_income'] = this.totleIncome;
    data['icon'] = this.icon;
    data['best_keep_coin'] = this.bestKeepCoin;
    data['min_keep_coin'] = this.minKeepCoin;
    data['coin_power'] = this.coinPower;
    data['genera_power'] = this.generaPower;
    data['lastday_income'] = this.lastdayIncome;
    data['totle_income_cny'] = this.totleIncomeCny;
    data['coin_power_cny'] = this.coinPowerCny;
    data['genera_power_cny'] = this.generaPowerCny;
    data['lastday_income_cny'] = this.lastdayIncomeCny;
    return data;
  }
}
