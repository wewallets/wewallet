import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

import 'bundle.dart';

typedef Widget HandlerFunc(
    BuildContext context, Map<String, List<String>> parameters);
typedef Widget PageBuilderFunc(Bundle bundle);

class PageBuilder extends Handler{
  final PageBuilderFunc builder;
  HandlerFunc handlerFunc;

  PageBuilder({this.builder}) {
    this.handlerFunc = (context, _) {
      return this.builder(ModalRoute.of(context).settings.arguments as Bundle);
    };
  }

  Handler getHandler() {
    return Handler(handlerFunc: this.handlerFunc);
  }
}
