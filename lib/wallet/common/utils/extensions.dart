import 'package:flutter/material.dart';
import 'package:mars/wallet/common/component_index.dart';

extension OnPressed on Widget {
  Widget ripple(Function onPressed, {BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(5))}) => Stack(
        children: <Widget>[
          this,
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: inkButton(
                  onPressed: () {
                    if (onPressed != null) {
                      onPressed();
                    }
                  },
                  child: Container()))
        ],
      );
}
