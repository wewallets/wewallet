import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'base_dialog.dart';

//保存二维码
// ignore: must_be_immutable
class SaveQRCodeDialog extends StatelessWidget {
  SaveQRCodeDialog(this.qrCode, this.content);

  final String qrCode;
  final String content;
  GlobalKey _renderObjectKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      cornerRadius: 0.0,
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      widget: Container(
        color: Colours.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: ScreenUtil().setWidth(550),
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(ScreenUtil().setWidth(14)), topLeft: Radius.circular(ScreenUtil().setWidth(14))), color: Colours.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                      alignment: Alignment.topRight,
                      child: InkResponse(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(child: LoadImage(Images.combined_shape_26671, width: ScreenUtil().setWidth(30)), padding: EdgeInsets.all(ScreenUtil().setWidth(30))),
                      )),
                  InkResponse(
                    child: Center(child: RepaintBoundary(key: _renderObjectKey, child: QrImage(foregroundColor: Color(0xFF000000), padding: EdgeInsets.zero, data: qrCode, size: ScreenUtil().setWidth(320), backgroundColor: Colors.white))),
                    onTap: () async {
                      await Permission.storage.request().then((value) async {
                        if ( value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
                          Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "获取权限失败～");
                        } else {


                          try {
                            RenderRepaintBoundary boundary = _renderObjectKey.currentContext.findRenderObject();
                            var image = await boundary.toImage(pixelRatio: 3.0);
                            ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
                            ImageGallerySaver.saveImage(byteData.buffer.asUint8List());
                            // final image = await QrPainter(data: qrCode, version: QrVersions.auto, gapless: true).toImage(ScreenUtil().setWidth(320));
                            // final a = await image.toByteData(format: ImageByteFormat.png);
                            // ImageGallerySaver.saveImage(a.buffer.asUint8List());
                            Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '成功保存相册～');
                          } catch (exception) {
                            Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: "保存失败～");
                          }
                          Navigator.of(context).pop();
                        }
                      });
                    },
                  ),
                  Gaps.vGap10,
                  Text('$content', textAlign: TextAlign.center, style: TextStyle(color: Colours.FF757CB2, fontSize: ScreenUtil().setSp(24))),
                ],
              ),
            ),
          ],
        ),
      ),
      entryAnimation: EntryAnimation.DEFAULT,
    );
  }
}
