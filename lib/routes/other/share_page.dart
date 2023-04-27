import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:qr_flutter/qr_flutter.dart';

//邀请好友下载APP
class SharePage extends StatefulWidget {
  @override
  _SharePageState createState() => _SharePageState();
}

class _SharePageState extends State<SharePage> {
  String share = '${ApiTransaction.BASE_URL}explorer/download.html';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LoadImage('account_bg', fit: BoxFit.fill, width: double.infinity, height: double.infinity),
          ListView(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(350)),
            children: [
              Container(
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('share_zj_bg')), fit: BoxFit.fill)),
                height: ScreenUtil().setWidth(800),
                margin: EdgeInsets.only(left: ScreenUtil().setWidth(74), right: ScreenUtil().setWidth(74)),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Gaps.vGap40, //share_code_bg
                    Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('share_zj_bg')), fit: BoxFit.fill)),
                      child: QrImage(padding: EdgeInsets.zero, data: share, size: ScreenUtil().setWidth(440), backgroundColor: Colors.white),
                    ),
                    // Gaps.vGap20,
                    // Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)), child: Text('邀请好友下载后，并帮助好友激活后，才能形成您的联系人网络，和朋友间建立社区网络挖矿节点！', style: TextStyles.textBlack12)),
                    Gaps.vGap30,
                    InkWell(
                        onTap: () {
                          Clipboard.setData(new ClipboardData(text: share));
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                        },
                        child: Container(
                          decoration: BoxDecoration(color: Colours.themeColor, borderRadius: BorderRadius.circular(ScreenUtil().setWidth(6))),
                          alignment: Alignment.center,
                          height: ScreenUtil().setWidth(88),
                          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                          margin: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              LoadImage('share_fza', width: ScreenUtil().setWidth(39)),
                              Gaps.hGap10,
                              Text('${getString().fzxzlj}', style: TextStyles.textWhite12),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
          // Container(child: LoadImage('ic_launcher', width: ScreenUtil().setWidth(150)), margin: EdgeInsets.only(top: ScreenUtil().setWidth(260)), alignment: Alignment.topCenter),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight, right: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(10)),
              child: Stack(
                children: [
                  CupertinoButton(
                    child: LoadAssetImage('break_black', width: ScreenUtil().setWidth(44), fit: BoxFit.contain, color: Colours.white),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.pop(context);
                    },
                  ),
                  Align(alignment: Alignment.topCenter, child: Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(15)), child: Text('${getString().yqhyxzapp}', style: Styles.textTitle.copyWith(fontWeight: FontWeight.w500, color: Colours.white)))),
                  // GestureDetector(
                  //   child: Text('', style: TextStyles.textWhite16),
                  //   onTap: () {
                  //   },
                  // ),
                ],
              )),
        ],
      ),
    );
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: LayoutUtil.getAppBar(context, '邀请好友下载APP'),
      body: Stack(
        children: [
          LoadImage('fengxiangxiaz', height: ScreenUtil().setWidth(810), fit: BoxFit.fitWidth, width: double.infinity),
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(700), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
            child: Text('邀请好友下载后，并帮助好友激活后，才能形成您的联系人网络，和朋友间建立社区网络挖矿节点！', style: TextStyle(color: Color(0xFF607FB8), fontSize: ScreenUtil().setWidth(24))),
          ),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(830), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
              child: InkWell(
                  onTap: () {
                    Clipboard.setData(new ClipboardData(text: '${ApiTransaction.BASE_URL}explorer/download.html'));
                    Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().fzcg}');
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                    height: ScreenUtil().setWidth(92),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            LoadImage(
                              'fuzhixiaz',
                              width: ScreenUtil().setWidth(40),
                              height: ScreenUtil().setWidth(40),
                            ),
                            Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(24))),
                            Text('复制下载链转发给好友', style: TextStyles.textBlack14)
                          ],
                        ),
                        Row(
                          children: [
                            Text('', style: TextStyles.text757CB224),
                            Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                            LoadImage(
                              'icon_goto',
                              width: ScreenUtil().setWidth(25),
                              height: ScreenUtil().setWidth(24),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))),
        ],
      ),
    );
  }
}
