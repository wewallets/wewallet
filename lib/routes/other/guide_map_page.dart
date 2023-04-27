import 'package:mars/common/transaction_component_index.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

//引导图
class GuideMapPage extends StatefulWidget {
  @override
  _GuideMapPageState createState() => _GuideMapPageState();
}

enum Direction { LEFT, RIGHT }

class _GuideMapPageState extends State<GuideMapPage> with TickerProviderStateMixin {
  List<String> cardList = ["yindaotu1", "yindaotu2", "yindaotu3", ''];
  AnimationController controller;
  AnimationController sizeController;
  CurvedAnimation curve;

  double scrollPercent = 0.0;
  bool isHome = false;

  Future<bool> _requestPop() {
    Navigator.pushReplacementNamed(context, PageTransactionRouter.main_page);
    return new Future.value(false);
  }

  @override
  void initState() {
    super.initState();
    sizeController = AnimationController(lowerBound: 0.9, upperBound: 1.1, duration: const Duration(milliseconds: 500), vsync: this);
    controller = new AnimationController(duration: const Duration(milliseconds: 1300), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: kToolbarHeight, right: ScreenUtil().setWidth(40)),
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, PageTransactionRouter.main_page);
                    },
                    child: LoadImage('yindaotutg', width: ScreenUtil().setWidth(110), height: ScreenUtil().setWidth(52), fit: BoxFit.fill)),
              ),
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(10)),
                      child: Swiper(
                        onIndexChanged: (index) {
                          if (index == 3) {
                            Navigator.pushReplacementNamed(context, PageTransactionRouter.main_page);
                          }
                        },
                        loop: false,
                        scale: 0.7,
                        itemBuilder: (BuildContext context, int index) {
                          return LoadAssetImage(cardList[index], fit: BoxFit.contain);
                        },
                        itemCount: cardList.length,
                      ))),
            ],
          ),
        ));
  }
}

/// 底部导航
class BottomBar extends StatefulWidget {
  BottomBar({this.cardCount, this.scrollPercent});

  final int cardCount;
  final double scrollPercent;

  @override
  _BottomBarState createState() {
    return _BottomBarState();
  }
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15.0, bottom: 100),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 145.0, right: 145.0),

              /// 底部导航高度
              height: 3,
              child: CustomPaint(
                painter: ScrollIndicatorPainter(
                  cardCount: widget.cardCount,
                  scrollPercent: widget.scrollPercent,

                  /// 导航指针宽度，
                  /// 配合导航条高度的设置可实现 圆形导航指针、扁平导航指针
//                  trackW: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 导航条
class ScrollIndicatorPainter extends CustomPainter {
  ScrollIndicatorPainter({this.cardCount, this.scrollPercent, this.trackW = 20})
      : trackPaint = Paint()
          ..color = Colours.colorEE
          ..style = PaintingStyle.fill,
        thumbPaint = Paint()
          ..color = Colours.themeColor
          ..style = PaintingStyle.fill;

  final int cardCount;
  final double scrollPercent;
  final Paint trackPaint;
  final Paint thumbPaint;

  /// 指针宽度
  final double trackW;

  @override
  void paint(Canvas canvas, Size size) {
    /// 指针预定轨道图
    double startL = size.width / 8 - trackW / 2;
    for (int i = 0; i < cardCount; i++) {
      canvas.drawRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(startL + size.width / 4 * i, 0.0, trackW, size.height),
          topLeft: Radius.circular(3.0),
          topRight: Radius.circular(3.0),
          bottomLeft: Radius.circular(3.0),
          bottomRight: Radius.circular(3.0),
        ),
        trackPaint,
      );
    }

    /// 指针图
    final thumbLeft = scrollPercent * size.width + startL;
    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(thumbLeft, 0.0, trackW, size.height),
        topLeft: Radius.circular(3.0),
        topRight: Radius.circular(3.0),
        bottomLeft: Radius.circular(3.0),
        bottomRight: Radius.circular(3.0),
      ),
      thumbPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
