import 'package:mars/common/transaction_component_index.dart';

/**
 * 公告列表
 */
class NoticePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _NoticeState();
}

class _NoticeState extends State<NoticePage> {
  List<String> _allList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _allList.add('value');
    _allList.add('value');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, '公告列表'),
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: new SliverChildBuilderDelegate((ctx, index) {
              return _itemView(index);
            }, childCount: _allList.length),
          )
        ]));
  }

  _itemView(int index) {
   return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
          height: ScreenUtil().setWidth(132),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('关于DXB.COM恢复USDT充提业务的公告',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.textBlack14),
                  ),
                  LoadImage(
                    'icon_goto',
                    width: ScreenUtil().setWidth(25),
                    height: ScreenUtil().setWidth(25),
                  )
                ],
              ),
              Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(20))),
              Text('2小时前', style: TextStyles.textGrey12)
            ],
          ),
        ),
        Container(
          color: Colours.colorEE,
          height: ScreenUtil().setWidth(1),
          margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        )
      ],
    );
  }
}
