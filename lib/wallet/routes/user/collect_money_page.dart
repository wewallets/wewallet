import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class CollectMoneyPage extends StatefulWidget {
  final Bundle bundle;

  CollectMoneyPage(this.bundle);

  @override
  _CollectMoneyPageState createState() => _CollectMoneyPageState();
}

class _CollectMoneyPageState extends BaseState<CollectMoneyPage> {
  GlobalKey _renderObjectKey = GlobalKey();

  @override
  Widget get appBar => getAppBar('收款');

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Color get backgroundColor => Color(0xFFF3F6FB);

  @override
  Widget buildContent(BuildContext context) {
    return ListView(padding: EdgeInsets.all(dp(30)), children: [
      Container(
          padding: EdgeInsets.only(top: dp(40), bottom: dp(20)),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
          child: Column(children: [
            Center(child: QrImage(padding: EdgeInsets.zero, data: '', size: dp(235), backgroundColor: Colors.white)),
            Gaps.vGap30,
            LoadImage('collect_fg', width: double.infinity, height: dp(20)),
            Gaps.vGap10,
            Text('${Global.userWallet.wallet.address}', style: TextStyles().textBlack12),
            Gaps.vGap10,
            inkButton(
                onPressed: () {
                  Clipboard.setData(new ClipboardData(text: '${Global.userWallet.wallet.address}'));
                  showToast('复制成功');
                },
                child: Text('点击可复制', style: TextStyles().textTheme12)),
          ])),
      Gaps.vGap15,
      inkButton(
          onPressed: () async {
            await Permission.storage.request().then((value) async {
              if (value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
                Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "获取权限失败");
              } else {
                try {
                  RenderRepaintBoundary boundary = _renderObjectKey.currentContext?.findRenderObject();
                  var image = await boundary.toImage(pixelRatio: 3.0);
                  ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
                  ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: '成功保存相册');
                } catch (exception) {
                  Fluttertoast.showToast(gravity: ToastGravity.CENTER, msg: "保存失败");
                }
                Navigator.of(context).pop();
              }
            });
          },
          child: Container(
              padding: EdgeInsets.only(top: dp(15), bottom: dp(15)),
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(dp(8))), color: Colours().white),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                LoadImage('sk_bc', width: dp(24), height: dp(24)),
                Gaps.vGap5,
                Text('保存到相册', style: TextStyles().textTheme14),
              ]))),
    ]);
  }

  getData() {}
}
