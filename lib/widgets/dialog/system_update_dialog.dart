import 'dart:io';

import 'package:dio/dio.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/index.dart';
import 'package:path_provider/path_provider.dart';
import 'base_dialog.dart';

//系统更新
// ignore: must_be_immutable
class SystemUpdateDialog extends StatefulWidget {
  final AppConfig appConfig;

  SystemUpdateDialog(this.appConfig);

  @override
  _SystemUpdateDialogState createState() => _SystemUpdateDialogState();
}

class _SystemUpdateDialogState extends State<SystemUpdateDialog> {
  int progress = 0;
  bool isDownload = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          if (widget.appConfig.forced_update == '1')
            return new Future.value(true);
          else
            return new Future.value(false);
        },
        child: BaseDialog(
          widget: Container(
            color: Colours.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: ScreenUtil().setWidth(520),
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('update_bg')), fit: BoxFit.fill)),
                  constraints: BoxConstraints(minHeight: ScreenUtil().setWidth(582)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: ScreenUtil().setWidth(67), left: ScreenUtil().setWidth(50)),
                        child: Text('版本升级', style: TextStyle(color: Colours.white, fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(46))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: ScreenUtil().setWidth(155), left: ScreenUtil().setWidth(50)),
                        child: Text('更新内容', style: TextStyle(color: Colours.textBlack, fontWeight: FontWeight.bold, fontSize: ScreenUtil().setSp(28))),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
                        child: Text('${widget.appConfig.content}', style: TextStyle(color: Colours.textGrey6, fontSize: ScreenUtil().setSp(28))),
                      ),
                      !isDownload
                          ? Padding(
                              padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(50)),
                              child: Center(
                                  child: InkResponse(
                                      onTap: () {
                                        isDownload = true;
                                        setState(() {});
                                        installApk(widget.appConfig.android_addr);
                                      },
                                      child: Container(
                                        width: ScreenUtil().setWidth(440),
                                        height: ScreenUtil().setWidth(80),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Colours.themeColor, width: 1)),
                                        child: Text('开始升级', style: TextStyles.textBlack16),
                                      ))))
                          : Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), bottom: ScreenUtil().setWidth(50)), child: Center(child: ProgressBarWidget(progress))),
                    ],
                  ),
                ),
                Gaps.vGap15,
                widget.appConfig.forced_update == '1'
                    ? InkResponse(
                        child: LoadImage('update_gb', width: ScreenUtil().setWidth(66), height: ScreenUtil().setWidth(66), fit: BoxFit.fill),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
              ],
            ),
          ),
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          cornerRadius: 0.0,
          entryAnimation: EntryAnimation.DEFAULT,
        ));
  }

  Future<File> downloadAndroid(String url) async {
    Directory storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir.path;
    File file = File('$storagePath/app.apk');
    Response response = await Dio().get(url, options: Options(responseType: ResponseType.bytes, followRedirects: false), onReceiveProgress: (received, total) {
      if (total != -1) {
        progress = (received / total * 100).toInt();
        if (mounted) setState(() {});
      }
    });
    file.writeAsBytesSync(response.data);
    return file;
  }

  void showDownloadProgress(num received, num total) {
    if (total != -1) {
      progress = double.parse((received / total).toStringAsFixed(2)).toInt();
      setState(() {});
    }
  }

  Future<Null> installApk(String url) async {
    File _apkFile = await downloadAndroid(url);

    if (_apkFile == null) return;
    String _apkFilePath = _apkFile.path;

    if (_apkFilePath.isEmpty) {
      print('make sure the apk file is set');
      return;
    }

    InstallPlugin.installApk(_apkFilePath, 'com.rise.app').then((result) {
      print('install apk $result');
    }).catchError((error) {
      print('install apk error: $error');
    });
  }
}

class ProgressBarWidget extends StatelessWidget {
  final int progress;

  ProgressBarWidget(this.progress);

  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().setWidth(440),
      height: ScreenUtil().setWidth(80),
      child: Stack(
        children: <Widget>[
          Container(decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Colours.themeColor, width: 1))),
          Container(
            width: progress / 100 * ScreenUtil().setWidth(440),
            height: double.infinity,
            decoration: BoxDecoration(color: Colours.themeColor, borderRadius: BorderRadius.all(Radius.circular(progress == 100 ? 4 : 0))),
          ),
          Center(child: Text('$progress%', style: progress >= 60 ? TextStyles.textWhite16 : TextStyles.textBlack16)),
        ],
      ),
    );
  }
}
