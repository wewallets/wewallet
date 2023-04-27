import 'package:mars/models/Dapp_article_list.dart';
import 'package:mars/models/Dapp_category.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DAPPPage extends StatefulWidget {
  @override
  _DAPPPageState createState() => _DAPPPageState();
}

class _DAPPPageState extends BaseAliveState<DAPPPage> with TickerProviderStateMixin {
  RefreshController refreshController = RefreshController();
  TextEditingController searchKeyController = TextEditingController();

  TabController controller;
  DappCategory dAPPLevel;
  List<DappArticleList> list = [];
  List<DappCategory> categoryList = [];
  String searchKey;
  bool isData = false;

  @override
  Widget get appBar => getAppBar('DAPP', noLeading: true);

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  void initState() {
    super.initState();
    initData();
    getCategory();
  }

  @override
  Color get backgroundColor => Color(0xFFF3F6FB);

  @override
  Widget buildContent(BuildContext context) {
    return Column(children: [
      Gaps.vGap15,
      Container(
        margin: EdgeInsets.only(left: dp(15), right: dp(15), bottom: dp(15)),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
        child: Column(
          children: [
            // Container(height: dp(115), color: Colours().colorFF4683C6, width: double.infinity),
            ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(dp(8)), topRight: Radius.circular(dp(8))), child: LoadImage('dqzy_bg', width: double.infinity, height: dp(115))),
            Row(
              children: [
                Gaps.hGap15,
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  height: dp(50),
                  child: Row(
                    children: [
                      LoadImage('dapp_search', width: dp(24), height: dp(24)),
                      Gaps.hGap10,
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(5)),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: searchKeyController,
                                style: TextStyles().textBlack14,
                                onSubmitted: (str) {
                                  navigateTo(PageWalletRouter.webview_page,
                                      bundle: Bundle()
                                        ..putString('url', str)
                                        ..putString('titleName', 'DAPP'));
                                },
                                decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '搜索或输入网址', hintStyle: TextStyles().textGrey14),
                              ))),
                    ],
                  ),
                )),
                Gaps.hGap5,
                // LoadImage('dapp_sys', width: dp(24)),
                Gaps.hGap15,
              ],
            ),
          ],
        ),
      ),
      categoryList.length == 0
          ? buildLoadingShadeCustom(top: 100)
          : Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: dp(12), bottom: ScreenUtil().setWidth(22)),
              height: ScreenUtil().setWidth(60),
              child: TabBar(
                unselectedLabelColor: Colours().textBlack,
                unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(28)),
                labelColor: Colours().themeColor,
                labelStyle: TextStyle(fontSize: ScreenUtil().setSp(28)),
                controller: controller,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: EdgeInsets.only(left: dp(20), right: dp(20)),
                indicatorColor: Colours().themeColor,
                onTap: (index) {
                  dAPPLevel = categoryList[index];
                  list.clear();
                  setState(() {});

                  getData(isRefresh: false);
                },
                tabs: categoryList.map((DappCategory category) {
                  return Text('${category.dappCategoryName}');
                }).toList(),
              ),
            ),
      Expanded(
          child: categoryList.length == 0
              ? Container()
              : !isData
                  ? buildErrorWidget()
                  : list.length == 0
                      ? Container()
                      : listViewBuilder(
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return getItem(index);
                          })),
    ]);
  }

  getItem(index) {
    return inkButton(
        onPressed: () {
          navigateTo(PageWalletRouter.webview_page,
              bundle: Bundle()
                ..putString('url', list[index].dappArticleUrl)
                ..putString('titleName', list[index].dappArticleTitle));
        },
        child: Container(
          margin: EdgeInsets.only(left: dp(15), right: dp(15), bottom: dp(15)),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
          padding: EdgeInsets.all(dp(15)),
          child: Row(
            children: [
              LoadImage('${list[index].dappArticleIcon}', width: dp(50), height: dp(50)),
              Gaps.hGap10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${list[index].dappArticleTitle}', style: TextStyles().textBlack16),
                  Gaps.vGap2,
                  Text('${list[index].dappArticleInro}', style: TextStyles().textGrey12),
                ],
              ),
              Expanded(child: Container()),
              LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
            ],
          ),
        ));
  }

  initData() {
    if (SpWalletUtil.hasKey('dappCategoryList')) {
      categoryList = SpWalletUtil.getObjList('dappCategoryList', (v) => DappCategory.fromJson(v));
      controller = TabController(vsync: this, length: categoryList.length);
      dAPPLevel = categoryList[0];

      if (SpWalletUtil.hasKey('dappArticleList')) {
        list = SpWalletUtil.getObjList('dappArticleList', (v) => DappArticleList.fromJson(v));
      }
    }

    setState(() {});
  }

  getCategory() {
  }

  getData({bool isRefresh = true}) {
  }
}
