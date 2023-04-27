import 'package:mars/common/transaction_component_index.dart';

class AppFloatBox extends StatefulWidget {
  @override
  _AppFloatBoxState createState() => _AppFloatBoxState();
}

class _AppFloatBoxState extends State<AppFloatBox> {
  int type = 0;
  Offset offset = Offset(ScreenUtil().screenWidth - adaptationDp(140), ScreenUtil().statusBarHeight + kToolbarHeight);

  Offset _calOffset(Size size, Offset offset, Offset nextOffset) {
    double dx = 0;
    //水平方向偏移量不能小于0不能大于屏幕最大宽度
    if (offset.dx + nextOffset.dx <= 0) {
      dx = 0;
    } else if (offset.dx + nextOffset.dx >= (size.width - 50)) {
      dx = size.width - 50;
    } else {
      dx = offset.dx + nextOffset.dx;
    }
    double dy = 0;
    //垂直方向偏移量不能小于0不能大于屏幕最大高度
    if (offset.dy + nextOffset.dy >= (size.height - 100)) {
      dy = size.height - 100;
    } else if (offset.dy + nextOffset.dy <= kToolbarHeight) {
      dy = kToolbarHeight;
    } else {
      dy = offset.dy + nextOffset.dy;
    }
    return Offset(
      dx,
      dy,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (detail) {
          setState(() {
            offset = _calOffset(MediaQuery.of(context).size, offset, detail.delta);
          });
        },
        onPanEnd: (detail) {},
        onTap: () {
          if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageTransactionRouter.share_page);
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(type == 1 ? 3:15),
              child: LoadImage('yaoqinghaoyoufd', width: adaptationDp(type == 1 ? 80 : 140)),
            ),
            type == 1 ? Container(): inkButton(
                onPressed: () {
                  type = 1;
                  offset = Offset(ScreenUtil().screenWidth - adaptationDp(80), ScreenUtil().statusBarHeight + kToolbarHeight);
                  setState(() {});
                },
                child: Padding(padding: EdgeInsets.only(right: adaptationDp(5), top: adaptationDp(5)), child: LoadImage('delete_text', width: adaptationDp(15)))),
          ],
        ),
        // child: inkButton(
        //     child: LoadImage('yaoqinghaoyoufd', width: adaptationDp(160)),
        //     onPressed: () {
        //       if (LayoutUtil.isLogin(context, isShowLogin: true)) Navigator.pushNamed(context, PageRouter.share_page);
        //     }),
      ),
    );
  }
}
