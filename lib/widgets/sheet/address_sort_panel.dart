import 'package:mars/common/transaction_component_index.dart';

/**
 * 地址排序
 */
class AddressSortPanel extends StatefulWidget {
  final int sortValue;

  AddressSortPanel(this.sortValue);

  @override
  State<StatefulWidget> createState() => _AddressSortPanelState();
}

class _AddressSortPanelState extends State<AddressSortPanel> {
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
            decoration: BoxDecoration(
                color: Colours.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14))),
            child: Column(
              children: <Widget>[
                Container(
                  height: ScreenUtil().setWidth(130),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(14),
                          topRight: Radius.circular(14))),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Text(
                        '请选择排序方式',
                        style: TextStyles.textBlack18,
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
                ),
                Container(
                  color: Colours.color1A000000,
                  width: double.infinity,
                  height: ScreenUtil().setWidth(1),
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  height: ScreenUtil().setWidth(68),
                  child: Text('默认创建时间', style: TextStyles.textGrey614),
                ),
                Container(
                  color: Colours.color1A000000,
                  width: double.infinity,
                  height: ScreenUtil().setWidth(1),
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  height: ScreenUtil().setWidth(68),
                  child: Text('资产字母', style: TextStyles.textGrey614),
                ),
                Container(
                  color: Colours.color1A000000,
                  width: double.infinity,
                  height: ScreenUtil().setWidth(1),
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                  height: ScreenUtil().setWidth(68),
                  child: Text('钱包名称', style: TextStyles.textGrey614),
                ),
                Container(
                  color: Colours.color1A000000,
                  width: double.infinity,
                  height: ScreenUtil().setWidth(1),
                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right:ScreenUtil().setWidth(30),left: ScreenUtil().setWidth(30),top: ScreenUtil().setWidth(42),bottom: ScreenUtil().setWidth(40) ),
                  decoration: BoxDecoration(
                      color: Colours.colorButton2,
                      borderRadius: BorderRadius.circular(6)),
                  height: ScreenUtil().setWidth(88),
                  child: Text(
                    '确定',
                    style: TextStyles.textWhite16,
                  ),
                )
              ],
              mainAxisSize: MainAxisSize.min,
            ),
          )
        ],
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
  }
}
