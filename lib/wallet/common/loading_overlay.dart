import 'package:flutter/material.dart';
import 'package:mars/wallet/common/top_overlay.dart';

class LoadingOverlay extends TopOverlay {
  LoadingOverlay({
    Key key,
    child
  }) {
    this.child = build();
  }

  Widget child;

  Widget build() {
    return const Center(
      child: CircularProgressIndicator()
    );
  }

}

LoadingOverlay loadingOverlay = LoadingOverlay();
