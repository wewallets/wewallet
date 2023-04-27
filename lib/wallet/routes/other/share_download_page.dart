import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mars/wallet/common/component_index.dart';

class ShareDownloadPage extends StatefulWidget {
  @override
  _ShareDownloadPageState createState() => _ShareDownloadPageState();
}

class _ShareDownloadPageState extends BaseState<ShareDownloadPage> {
  String share = '';

  @override
  Widget get appBar => null;

  @override
  Color get backgroundColor => Colours().white;

  @override
  void initState() {
    super.initState();
    getShare();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Stack(children: [
      LoadImage('fenxiangbeij', width: double.infinity, height: double.infinity),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: dp(70)),
          Text('${s.text434.toUpperCase()}', style: TextStyles().textWhite20),
          Container(height: dp(41)),
          LoadImage('fenxiangxt', width: dp(323), height: dp(202)),
          Container(
            decoration: BoxDecoration(border: Border.all(color: Color(0xFF82A5FF), width: dp(10)), borderRadius: BorderRadius.all(Radius.circular(dp(20))), color: Colours().white),
            padding: EdgeInsets.all(dp(26)),
            margin: EdgeInsets.only(left: dp(15), right: dp(15)),
            child: Column(
              children: [
                share == ''
                    ? Container(height: dp(180),child: buildLoadingShadeCustom())
                    : Container(
                        padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(30)),
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('share_zj_bg')), fit: BoxFit.fill)),
                        child: QrImage(padding: EdgeInsets.zero, data: share, size: dp(180), backgroundColor: Colors.white),
                      ),
                Text('${s.text435}', style: TextStyles().textGrey12),
                Gaps.vGap10,
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(child: Container(height: dp(1), color: Colours().themeColor, width: double.infinity)),
                  Gaps.hGap12,
                  LoadImage('fenxianglogo', width: dp(20)),
                  Gaps.hGap12,
                  Expanded(child: Container(height: dp(1), color: Colours().themeColor, width: double.infinity)),
                ]),
                Gaps.vGap15,
                inkButton(
                  onPressed: () {
                    showToast('${s.text52}');
                    Clipboard.setData(ClipboardData(text: share));
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(6))), color: Color(0xFF6AC0B3)), width: double.infinity, alignment: Alignment.center, child: Text('${s.text436}', style: TextStyles().textWhite12), height: dp(44)),
                ),
              ],
            ),
          )
        ],
      ),
      Padding(
          padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight, right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(10)),
          child: Stack(
            children: [
              CupertinoButton(
                child: LoadAssetImage('break_left', width: ScreenUtil().setWidth(44), fit: BoxFit.contain, color: Colours().white),
                padding: EdgeInsets.zero,
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  Navigator.pop(context);
                },
              ),
            ],
          )),
    ]);
  }

  getShare() {

  }
}
