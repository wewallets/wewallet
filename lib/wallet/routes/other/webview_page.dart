import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mars/wallet/common/component_index.dart';

//通用webView
class WebViewPage extends StatefulWidget {
  final Bundle bundle;

  WebViewPage(this.bundle);

  @override
  State<StatefulWidget> createState() => _WebViewState();
}

class _WebViewState extends BaseState<WebViewPage> {
  String url;
  String type = '';
  String title = '';
  double alpha = 0.5;
  double progressValue = 0;

  InAppWebViewController inAppWebView;
  String content;
  bool noLeading = false;

  @override
  void initState() {
    super.initState();

    if (widget.bundle != null && widget.bundle.isContainsKey('titleName')) {
      title = widget.bundle.getString('titleName');
    }
    if (widget.bundle != null && widget.bundle.isContainsKey('url')) {
      url = widget.bundle.getString('url');
      // url += '&locale=' + SpWalletUtil.getString('locale');
    }
    if (widget.bundle != null && widget.bundle.isContainsKey('content')) {
      content = widget.bundle.getString('content');
    }
    if (widget.bundle != null && widget.bundle.isContainsKey('noLeading')) {
      noLeading = widget.bundle.getBool('noLeading');
    }
  }

  @override
  Widget get appBar => getAppBar(title, onPressed: () {
        if (inAppWebView != null) {
          inAppWebView.canGoBack().then((value) {
            if (value) {
              inAppWebView.goBack();
            } else {
              Navigator.of(context).pop();
            }
          });
        } else {
          Navigator.of(context).pop();
        }
      }, noLeading: noLeading);

  @override
  Widget buildContent(BuildContext context) {
    return content != null
        ? Html(data: '$content')
        : Stack(
            children: <Widget>[
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(url)),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(verticalScrollBarEnabled: false, horizontalScrollBarEnabled: false, useShouldOverrideUrlLoading: true),
                  android: AndroidInAppWebViewOptions(hardwareAcceleration: true),
                  ios: IOSInAppWebViewOptions( allowsInlineMediaPlayback: true),
                ),
                onWebViewCreated: (controller) {
                  inAppWebView = controller;
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  return NavigationActionPolicy.ALLOW;
                },
                onProgressChanged: (InAppWebViewController controller, int progress) {
                  if (mounted) {
                    setState(() {
                      progressValue = double.parse(progress.toString());
                    });
                  }
                },
              ),
              Offstage(
                  child: SizedBox(
                    height: adaptation(4),
                    child: LinearProgressIndicator(value: progressValue / 100, backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation(Colours().themeColor)),
                  ),
                  offstage: progressValue == 100),
              Offstage(child: Center(child: buildLoadingShadeCustom()), offstage: progressValue == 100),
            ],
          );
  }

  _getPermission() async {
    if (Platform.isAndroid) {
      await Permission.camera.request().then((value) {
        if (value.isDenied || value.isPermanentlyDenied || value.isRestricted) {
          Navigator.of(context).maybePop();
        }
      });
    }
  }
}
