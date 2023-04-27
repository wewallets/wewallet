import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mars/wallet/common/component_index.dart';

//引导图
class GuideMapPage extends StatefulWidget {
  @override
  _GuideMapPageState createState() => _GuideMapPageState();
}

enum Direction { LEFT, RIGHT }

class _GuideMapPageState extends State<GuideMapPage> with TickerProviderStateMixin {
  List<String> cardList = ["guide1", "guide2", "guide3", ''];
  AnimationController controller;
  AnimationController sizeController;
  CurvedAnimation curve;

  double scrollPercent = 0.0;
  bool isHome = false;

  Future<bool> _requestPop() {
    Navigator.pushReplacementNamed(context, PageWalletRouter.main_page);
    return new Future.value(false);
  }

  @override
  void initState() {
    Global.getContext = context;
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
          body: Stack(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Swiper(
                    onIndexChanged: (index) {
                      if (index == 3) {
                        Navigator.pushReplacementNamed(context, PageWalletRouter.main_page);
                      }
                    },
                    loop: false,
                    scale: 0.7,
                    itemBuilder: (BuildContext context, int index) {
                      return cardList[index] == '' ? Container() : LoadAssetImage(cardList[index], fit: BoxFit.fitWidth);
                    },
                    itemCount: cardList.length,
                    pagination: new SwiperPagination(alignment: Alignment.bottomCenter, builder: DotSwiperPaginationBuilder(size: ScreenUtil().setWidth(9), activeSize: ScreenUtil().setWidth(9), color: Colours().colorFFD8D8D8, activeColor: Colours().themeColor)),
                    controller: new SwiperController(),
                  )),
              Container(
                padding: EdgeInsets.only(top: kToolbarHeight, right: ScreenUtil().setWidth(40)),
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, PageWalletRouter.main_page);
                    },
                    child: Text('${s.text206}', style: TextStyles().textGrey14)),
              ),
            ],
          ),
        ));
  }
}

/// 导航条
class ScrollIndicatorPainter extends CustomPainter {
  ScrollIndicatorPainter({this.cardCount, this.scrollPercent, this.trackW = 20})
      : trackPaint = Paint()
          ..color = Colours().colorEE
          ..style = PaintingStyle.fill,
        thumbPaint = Paint()
          ..color = Colours().themeColor
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
