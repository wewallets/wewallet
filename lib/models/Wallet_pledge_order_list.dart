class WalletPledgeOrderList {
  WalletPledgeOrderList({
      this.orderId, 
      this.pledgeId, 
      this.pledgeType, 
      this.pledgeExpireTime, 
      this.uid, 
      this.account, 
      this.payAmount, 
      this.payTid, 
      this.toAmount, 
      this.tid, 
      this.status, 
      this.createTime, 
      this.updateTime, 
      this.remark, 
      this.isSettlement, 
      this.lastSettleDate, 
      this.isCurrent, 
      this.title, 
      this.titleEn, 
      this.titleTh, 
      this.titleMs, 
      this.day, 
      this.rate, 
      this.statusStr, 
      this.pledgeTypeStr,});

  WalletPledgeOrderList.fromJson(dynamic json) {
    orderId = json['order_id'];
    pledgeId = json['pledge_id'];
    pledgeType = json['pledge_type'];
    pledgeExpireTime = json['pledge_expire_time'];
    uid = json['uid'];
    account = json['account'];
    payAmount = json['pay_amount'];
    payTid = json['pay_tid'];
    toAmount = json['to_amount'];
    tid = json['tid'];
    status = json['status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    remark = json['remark'];
    isSettlement = json['is_settlement'];
    lastSettleDate = json['last_settle_date'];
    isCurrent = json['is_current'];
    title = json['title'];
    titleEn = json['title_en'];
    titleTh = json['title_th'];
    titleMs = json['title_ms'];
    day = json['day'];
    rate = json['rate'];
    statusStr = json['status_str'];
    pledgeTypeStr = json['pledge_type_str'];
  }
  String orderId;
  String pledgeId;
  String pledgeType;
  String pledgeExpireTime;
  String uid;
  String account;
  String payAmount;
  String payTid;
  String toAmount;
  String tid;
  String status;
  String createTime;
  String updateTime;
  String remark;
  String isSettlement;
  String lastSettleDate;
  dynamic isCurrent;
  dynamic title;
  dynamic titleEn;
  dynamic titleTh;
  dynamic titleMs;
  String day;
  String rate;
  String statusStr;
  String pledgeTypeStr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = orderId;
    map['pledge_id'] = pledgeId;
    map['pledge_type'] = pledgeType;
    map['pledge_expire_time'] = pledgeExpireTime;
    map['uid'] = uid;
    map['account'] = account;
    map['pay_amount'] = payAmount;
    map['pay_tid'] = payTid;
    map['to_amount'] = toAmount;
    map['tid'] = tid;
    map['status'] = status;
    map['create_time'] = createTime;
    map['update_time'] = updateTime;
    map['remark'] = remark;
    map['is_settlement'] = isSettlement;
    map['last_settle_date'] = lastSettleDate;
    map['is_current'] = isCurrent;
    map['title'] = title;
    map['title_en'] = titleEn;
    map['title_th'] = titleTh;
    map['title_ms'] = titleMs;
    map['day'] = day;
    map['rate'] = rate;
    map['status_str'] = statusStr;
    map['pledge_type_str'] = pledgeTypeStr;
    return map;
  }

}