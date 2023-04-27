import 'package:mars/common/transaction_component_index.dart';
import 'package:flutter_qr_reader/flutter_qr_reader.dart';

class ScanViewSheetDialog extends StatefulWidget {
  final voidCallback;

  ScanViewSheetDialog(this.voidCallback);

  @override
  _ScanViewSheetDialogState createState() => _ScanViewSheetDialogState();
}

class _ScanViewSheetDialogState extends State<ScanViewSheetDialog> {
  // GlobalKey<QrcodeReaderViewState> _key = GlobalKey();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 50), () {
      isLoading = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colours.transparent,
        body: Stack(children: [
          isLoading
              ? QrReaderView(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().screenHeight,
                  callback: (container) {
                    container.startCamera((p0, p1) {
                      widget.voidCallback(p0);
                      container.stopCamera();
                      Navigator.pop(context);
                    });
                  },
                )
              : LayoutUtil.getLoadingShadeCustom(text: '正在加载...'),
          Padding(
              padding: EdgeInsets.only(top: ScreenUtil().statusBarHeight),
              child: AppBar(
                  leading: IconButton(
                    icon: LoadAssetImage("break_black", width: 25, fit: BoxFit.contain, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0)),
          Center(
              child: Container(
            margin: EdgeInsets.only(left: adaptationDp(80), right: adaptationDp(80)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(border: Border(left: BorderSide(color: Colours.themeColor, width: 3), top: BorderSide(color: Colours.themeColor, width: 3), right: BorderSide(color: Colours.transparent, width: 3), bottom: BorderSide(color: Colours.transparent, width: 3))),
                        width: 70,
                        height: 50),
                    Expanded(child: Container()),
                    Container(
                        decoration: BoxDecoration(border: Border(left: BorderSide(color: Colours.transparent, width: 3), top: BorderSide(color: Colours.themeColor, width: 3), right: BorderSide(color: Colours.themeColor, width: 3), bottom: BorderSide(color: Colours.transparent, width: 3))),
                        width: 70,
                        height: 50),
                  ],
                ),
                Gaps.vGap50,
                Gaps.vGap30,
                Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(border: Border(left: BorderSide(color: Colours.themeColor, width: 3), top: BorderSide(color: Colours.transparent, width: 3), right: BorderSide(color: Colours.transparent, width: 3), bottom: BorderSide(color: Colours.themeColor, width: 3))),
                        width: 70,
                        height: 50),
                    Expanded(child: Container()),
                    Container(
                        decoration: BoxDecoration(border: Border(left: BorderSide(color: Colours.transparent, width: 3), top: BorderSide(color: Colours.transparent, width: 3), right: BorderSide(color: Colours.themeColor, width: 3), bottom: BorderSide(color: Colours.themeColor, width: 3))),
                        width: 70,
                        height: 50),
                  ],
                ),
                Gaps.vGap50,
                Gaps.vGap50,

              ],
            ),
          ))
        ]));
  }
}
