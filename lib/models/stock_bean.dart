class StockBean {
  String color;
  String dealpri;
  String marketval;
  String nowpri;
  String positionnum;
  String stokname;
  String totalprofit;
  String totalprofitpre;
  String transno;
  String type;
  String valpositionnum;

  // 当日成交
  String num;
  String price;
  String trnvalue;

  // 清仓股票
  String date;
  String percent;
  String profit;
  String sell;

  //  交易消息
  String title;
  String time;
  String money;
  String stockno;

  // 资产变动
  String item;

  // 持仓
  String fee;
  String trnmoney;

  StockBean({
    this.color,
    this.dealpri,
    this.marketval,
    this.nowpri,
    this.positionnum,
    this.stokname,
    this.totalprofit,
    this.totalprofitpre,
    this.transno,
    this.type,
    this.valpositionnum,
    this.num,
    this.price,
    this.trnvalue,
    this.date,
    this.percent,
    this.profit,
    this.sell,
    this.title,
    this.time,
    this.money,
    this.stockno,
    this.fee,
    this.trnmoney,
    this.item,
  });

  StockBean.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    dealpri = json['dealpri'];
    marketval = json['marketval'];
    nowpri = json['nowpri'];
    positionnum = json['positionnum'];
    stokname = json['stockname'];
    totalprofit = json['totalprofit'];
    totalprofitpre = json['totalprofitpre'];
    transno = json['transno'];
    type = json['type'];
    valpositionnum = json['valpositionnum'];
    num = json['num'];
    price = json['price'];
    trnvalue = json['trnvalue'];
    date = json['date'];
    percent = json['percent'];
    profit = json['profit'];
    sell = json['sell'];
    title = json['title'];
    time = json['time'];
    money = json['money'];
    stockno = json['stockno'];
    fee = json['fee'];
    trnmoney = json['trnmoney'];
    item = json['item'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['dealpri'] = this.dealpri;
    data['marketval'] = this.marketval;
    data['nowpri'] = this.nowpri;
    data['positionnum'] = this.positionnum;
    data['stockname'] = this.stokname;
    data['totalprofit'] = this.totalprofit;
    data['totalprofitpre'] = this.totalprofitpre;
    data['transno'] = this.transno;
    data['type'] = this.type;
    data['num'] = this.num;
    data['price'] = this.price;
    data['trnvalue'] = this.trnvalue;
    data['valpositionnum'] = this.valpositionnum;
    data['date'] = this.date;
    data['percent'] = this.percent;
    data['profit'] = this.profit;
    data['sell'] = this.sell;
    data['title'] = this.title;
    data['time'] = this.time;
    data['money'] = this.money;
    data['stockno'] = this.stockno;
    data['fee'] = this.fee;
    data['trnmoney'] = this.trnmoney;
    data['item'] = this.item;
    return data;
  }
}
