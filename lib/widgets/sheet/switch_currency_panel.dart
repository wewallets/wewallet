import 'package:mars/common/transaction_component_index.dart';

/**
 * 切换币种
 */
class SwitchCurrencyPanel extends StatefulWidget {
  SwitchCurrencyPanel();

  @override
  State<StatefulWidget> createState() => _SwitchCurrencyPanelState();
}

class _SwitchCurrencyPanelState extends State<SwitchCurrencyPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Expanded(
              child: InkWell(
                  child: Container(),
                  onTap: () {
                    Navigator.of(context).maybePop();
                  },
                  splashColor: Colors.transparent)),
          Container(
            height: ScreenUtil().setWidth(494),
            decoration: BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14))),
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  itemBuilder: (context, index) {
                    return _itemView(index);
                  },
                  padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                  itemCount: 1,
                ),
                Align(
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setWidth(30),
                          right: ScreenUtil().setWidth(30)),
                      child: LoadImage(
                        'icon_address_close',
                        width: ScreenUtil().setWidth(30),
                        height: ScreenUtil().setWidth(30),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).maybePop();
                    },
                  ),
                  alignment: Alignment.topRight,
                ),
              ],
            ),
          )
        ],
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }

  _itemView(int index) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: ScreenUtil().setWidth(88),
          child: Text('${GlobalTransaction.coin}',
              overflow: TextOverflow.ellipsis, style: TextStyles.textBlack14),
        ),
        Container(
          color: Colours.colorEE,
          height: ScreenUtil().setWidth(1),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        )
      ],
    );
  }
}
