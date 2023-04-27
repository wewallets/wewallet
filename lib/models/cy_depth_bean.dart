

class CyDepthBean {
  int code;
  String msg;
  CyDepthData data;

  CyDepthBean({this.code, this.msg, this.data});

  CyDepthBean.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new CyDepthData.fromJson(json['data']) : null;
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

class CyDepthData {
  CyDepthTick tick;
  String status;
  int ts;
  String ch;

  CyDepthData({this.tick, this.status, this.ts, this.ch});

  CyDepthData.fromJson(Map<String, dynamic> json) {
    tick = json['tick'] != null ? new CyDepthTick.fromJson(json['tick']) : null;
    status = json['status'];
    ts = json['ts'];
    ch = json['ch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.tick != null) {
      data['tick'] = this.tick.toJson();
    }
    data['status'] = this.status;
    data['ts'] = this.ts;
    data['ch'] = this.ch;
    return data;
  }
}

class CyDepthTick {
//  List<DepthEntity> bids;
//  List<DepthEntity> asks;
  int version;
  int ts;

//  CyDepthTick({this.bids, this.asks, this.version, this.ts});

  CyDepthTick.fromJson(Map<String, dynamic> json) {
//    if (json['bids'] != null) {
//      bids = new List<DepthEntity>();
//      json['bids'].forEach((v) {
//        bids.add(new DepthEntity.fromJson(v));
//      });
//    }
//    if (json['asks'] != null) {
//      asks = new List<DepthEntity>();
//      json['asks'].forEach((v) {
//        asks.add(new DepthEntity.fromJson(v));
//      });
//    }
    version = json['version'];
    ts = json['ts'];
  }

  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.bids != null) {
//      data['bids'] = this.bids.map((v) => v.toJson()).toList();
//    }
//    if (this.asks != null) {
//      data['asks'] = this.asks.map((v) => v.toJson()).toList();
//    }
//    data['version'] = this.version;
//    data['ts'] = this.ts;
//    return data;
  }
}

// class CyDepthInfo {
//   String price;
//   String size;

//   CyDepthInfo({this.price, this.size});

//   CyDepthInfo.fromJson(Map<String, dynamic> json) {
//     price = json['price'];
//     size = json['size'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['price'] = this.price;
//     data['size'] = this.size;
//     return data;
//   }
// }
