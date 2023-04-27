import 'dart:io';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:mars/common/transaction_component_index.dart';

class WebView2Page extends StatefulWidget {
  final Bundle bundle;

  WebView2Page(this.bundle);

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends State<WebView2Page> {
  LayoutUtil layoutUtil = new LayoutUtil();
  String url;
  String type = '';
  String title = '';
  double alpha = 0.5;
  double progressValue = 0;

  // InAppWebViewController inAppWebView;

  @override
  void initState() {
    super.initState();

    if (widget.bundle != null && widget.bundle.isContainsKey('titleName')) {
      title = widget.bundle.getString('titleName');
    }
    if (widget.bundle != null && widget.bundle.isContainsKey('url')) {
      if (widget.bundle.getString('url').contains('?')) {
        if (widget.bundle.getString('url').contains('sign')) {
          String lang;
          if (SpUtil.getString('locale') == 'zh') {
            lang = 'cn';
          } else if (SpUtil.getString('locale') == 'en') {
            lang = 'en';
          } else if (SpUtil.getString('locale') == 'ms') {
            lang = 'mys';
          } else if (SpUtil.getString('locale') == 'th') {
            lang = 'tha';
          }

          url = widget.bundle.getString('url') + '&lang=${lang ?? 'en'}';
        } else
          url = widget.bundle.getString('url') + '&_language=${SpUtil.getString('locale') ?? 'en'}';
      } else {
        url = widget.bundle.getString('url') + '?_language=${SpUtil.getString('locale') ?? 'en'}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.white,
      appBar: LayoutUtil.getAppBar(context, title, onPressed: () {
        Navigator.of(context).pop();
      }),
      body: Stack(
        children: <Widget>[
          // InAppWebView(initialUrl: url),
          // Offstage(
          //     child: SizedBox(
          //       height: ScreenUtil().setWidth(4),
          //       child: LinearProgressIndicator(value: progressValue / 100, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation(Colours.themeColor)),
          //     ),
          //     offstage: progressValue == 100),
          // Offstage(child: Center(child: LayoutUtil.getLoadingShadeCustom(text: '${getString().zzjz}')), offstage: progressValue == 100),
        ],
      ),
    );
    //
    // return Scaffold(
    //   backgroundColor: Colours.white,
    //   appBar: LayoutUtil.getAppBar(context, title, onPressed: () {
    //     if (inAppWebView != null) {
    //       inAppWebView.canGoBack().then((value) {
    //         if (value) {
    //           inAppWebView.goBack();
    //         } else {
    //           Navigator.of(context).pop();
    //         }
    //       });
    //     } else {
    //       Navigator.of(context).pop();
    //     }
    //   }),
    //   body: Stack(
    //     children: <Widget>[
    //       InAppWebView(
    //         // initialUrl: url,
    //         initialUrlRequest: URLRequest(url: Uri.parse(url)),
    //         initialOptions: InAppWebViewGroupOptions(
    //           crossPlatform: InAppWebViewOptions(verticalScrollBarEnabled: false, horizontalScrollBarEnabled: false, useShouldOverrideUrlLoading: true),
    //           android: AndroidInAppWebViewOptions(hardwareAcceleration: true),
    //         ),
    //         onWebViewCreated: (controller) {
    //           inAppWebView = controller;
    //         },
    //         onProgressChanged: (InAppWebViewController controller, int progress) {
    //           if (mounted) {
    //             setState(() {
    //               progressValue = double.parse(progress.toString());
    //             });
    //           }
    //         },
    //       ),
    //       Offstage(
    //           child: SizedBox(
    //             height: ScreenUtil().setWidth(4),
    //             child: LinearProgressIndicator(value: progressValue / 100, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation(Colours.themeColor)),
    //           ),
    //           offstage: progressValue == 100),
    //       Offstage(child: Center(child: LayoutUtil.getLoadingShadeCustom(text: '${getString().zzjz}')), offstage: progressValue == 100),
    //     ],
    //   ),
    // );
  }
}
