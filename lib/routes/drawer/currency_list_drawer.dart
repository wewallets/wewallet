import 'package:flutter/material.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/btc_bean.dart';

class CurrencyListDrawer extends StatefulWidget {
  final String type;
  final int intoPage; //0:交易页面 1:K线

  CurrencyListDrawer({Key key, this.type, this.intoPage}) : super(key: key);

  @override
  _CurrencyListDrawerState createState() => _CurrencyListDrawerState();
}

class _CurrencyListDrawerState extends State<CurrencyListDrawer> {
  List<BTCBean> btcBeans = [];

  @override
  void initState() {
    super.initState();
    getCurrencyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF141F31),
      body:ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(index);
        },
        itemCount: btcBeans.length,
      ),
    );
  }

  _buildItem(int index) {
    BTCBean btcBean = btcBeans[index];
    Color newColor = Colours.colorFF1CBB8B;
    if (btcBean.riceFall.length > 0) {
      if (btcBean.riceFall.startsWith('-')) {
        newColor = Colours.colorFFEC4C67;
      }
    }
    return inkButton(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(40)),
            height: ScreenUtil().setWidth(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(children: [
                  TextSpan(text: btcBean.tradName, style: TextStyles.textWhite15.copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(text: '/${btcBean.baseName}', style: TextStyles.textWhite12.copyWith(color: Color(0xFF687D9C))),
                ])),
                Text(btcBean.price, style: TextStyle(color: newColor, fontSize: ScreenUtil().setSp(30)))
              ],
            ),
          ),
          Container(
            color: Color(0xFF283547),
            height: ScreenUtil().setWidth(1),
            width: double.infinity,
          )
        ],
      ),
      onPressed: () {
        widget.intoPage == 0 ? EventBus().send("tranSwitchCurrency", btcBean) : EventBus().send("kLineSwitchCurrency", btcBean);
        Navigator.pop(context);
      },
    );
  }

  // 获取币种列表
  getCurrencyList() {
    if (SpUtil.hasKey('tradpair${widget.type}')) {
      btcBeans = SpUtil.getObjList('tradpair${widget.type}', (v) => BTCBean.fromJson(v));
      setState(() {});
    }
    Net().post(ApiTransaction.BASE_CY_LIST, {'currency': widget.type}, success: (data) {
      btcBeans.clear();
      data.forEach((v) {
        btcBeans.add(BTCBean.fromJson(v));
      });
      SpUtil.putObjectList('tradpair${widget.type}', btcBeans);
    }, failure: (error) {
      showToast(error);
    });
  }

}
