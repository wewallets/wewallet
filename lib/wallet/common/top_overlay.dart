import 'package:mars/wallet/common/component_index.dart';

class TopOverlay extends ChangeNotifier {
  bool isShow = true;
  Widget child;
  var entry;

  void toggle() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (isShow == false) {
        isShow = true;
      } else if (isShow == true) {
        isShow = false;
      }

      notifyListeners();
    });
  }

  void show(context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (entry == null) {
        entry = OverlayEntry(
            builder: (_) {
              return SafeArea(
                  child: Material(
                      color: Colors.transparent,
                      child: Center(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color.fromRGBO(0, 0, 0, 0.1),
                                        Color.fromRGBO(0, 0, 0, 0.7)
                                      ]
                                  )
                              ),
                              child: child
                          )
                      )
                  )
              );
            }
        );

        Overlay.of(context).insert(entry);
      }
    });
  }

  void hide() {
    if (entry != null) {
      entry.remove();
      entry = null;
    }
  }
}

TopOverlay topOverlay = TopOverlay();
