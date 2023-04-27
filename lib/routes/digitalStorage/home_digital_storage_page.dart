import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mars/common/base/base_alive_state.dart';
import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/collection_product_list_entity.dart';
import 'package:mars/widgets/dialog/open_the_blind_box_dialog.dart';

import '../../common/base/base_state.dart';
import '../../models/banner_list_entity.dart';
import '../../models/noticeList.dart';
import '../../widgets/font_marquee.dart';

class HomeDigitalStoragePage extends StatefulWidget {
  @override
  _HomeDigitalStoragePageState createState() => _HomeDigitalStoragePageState();
}

class _HomeDigitalStoragePageState extends BaseAliveState<HomeDigitalStoragePage> with TickerProviderStateMixin {
  @override
  Widget get appBar => getAppBar('');
  List<NoticeList> noticeList = [];
  List<BannerListEntity> bannerList = [];
  List<CollectionProductListEntity> collectionProductListEntityList = [];
  AnimationController size1Controller;
  bool isData = false;

  @override
  void initState() {
    super.initState();
    size1Controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this, lowerBound: 1, upperBound: 1.1);

    getHomeData();
  }

  @override
  void dispose() {
    size1Controller.dispose();
    super.dispose();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: dp(12),left: dp(12),bottom: dp(12)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: dp(12)),
              width: double.infinity,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(10)), color: Color(0xFF161427)),
              child: Column(
                children: [
                  buildBannerHead,
                  buildNotice,
                ],
              ),
            ),
            collectionProductListEntityList.length == 0
                ? Expanded(child: ListView(
                padding: EdgeInsets.zero,
                children: [
                    Container(
                        margin: EdgeInsets.only(bottom: dp(12)),
                        width: double.infinity,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('home_manhebg')), fit: BoxFit.fill)),
                        height: dp(400),
                        alignment: Alignment.topCenter,
                        child: ScaleTransition(alignment: Alignment.topCenter, scale: size1Controller, child: LoadImage('home_manhe', height: dp(355)))),
                    isData
                        ? inkButton(
                            onPressed: () {},
                            child: Container(
                                margin: EdgeInsets.only(bottom: dp(30)),
                                width: double.infinity,
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill)),
                                height: dp(60),
                                alignment: Alignment.center,
                                child: Text('${s.text14}', style: TextStyles.textBlack18)))
                        : Container()
                  ]))
                : Expanded(child: listViewBuilder(
                padding:EdgeInsets.only(bottom: dp(55)),itemCount: collectionProductListEntityList.length, itemBuilder: (context, index) => _itemView(index))),
          ],
        ));
  }

  _itemView(index) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(bottom: dp(12)),
          width: double.infinity,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('home_manhebg')), fit: BoxFit.fill)),
          height: dp(400),
          alignment: Alignment.topCenter,
          child: ScaleTransition(alignment: Alignment.topCenter, scale: size1Controller, child: LoadImage('${collectionProductListEntityList[index].iconUrl}', height: dp(355)))),
      inkButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => OpenTheBlindBoxDialog(collectionProductListEntityList, index, (type, number) {
                    navigateTo(PageTransactionRouter.buy_digital_storage_page);
                  }));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: dp(30)), width: double.infinity, decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('main_button_bg')), fit: BoxFit.fill)), height: dp(60), alignment: Alignment.center, child: Text('${s.text13}', style: TextStyles.textBlack18)),
      ),
    ]);
  }

  get buildBannerHead {
    if (bannerList.length != 0) {
      return Container(
          width: double.infinity,
          height: adaptationDp(140),
          child: Swiper(
            fade: 0.2,
            autoplayDelay: 6000,
            duration: 500,
            itemCount: bannerList.length,
            autoplay: false,
            itemBuilder: (context, index) {
              return Container(width: double.infinity, height: double.infinity, child: LoadImage('${bannerList[index].bannerUrl}', width: double.infinity, height: double.infinity, fit: BoxFit.fill));
            },
            controller: SwiperController(),
            viewportFraction: 1,
            onTap: (index) {},
          ));
    }
    return Container(height: dp(140));
  }

  get buildNotice {
    return Container(
      height: ScreenUtil().setWidth(80),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: adaptationDp(12), right: adaptationDp(12)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        LoadImage('home_gonggaox', width: ScreenUtil().setWidth(44)),
        Gaps.hGap8,
        Expanded(
            child: noticeList == null || noticeList.length == 0
                ? Container()
                : FontMarquee(noticeList.length, (BuildContext context, int index) {
                    return Container(
                        width: double.infinity,
                        height: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, PageTransactionRouter.webview_page,
                                arguments: Bundle()
                                  ..putString('titleName', '${getString().ggxq}')
                                  ..putString('url', '${ApiTransaction.BASE_URL}explorer/notice_detail/${noticeList[index].id}.html'));
                          },
                          child: Text('${noticeList[index].title}', style: TextStyles.textWhite13.copyWith(overflow: TextOverflow.ellipsis), maxLines: 1),
                        ));
                  })),
      ]),
    );
  }

  getHomeData() {
    Net().post(ApiTransaction.BASIC_AGREEMENT, {'flag': 14}, success: (data) {
      noticeList.clear();
      data.forEach((element) {
        noticeList.add(NoticeList.fromJson(element));
      });
      if (mounted) setState(() {});
    });
    Net().post(ApiTransaction.banner_list, {'type': '3'}, success: (data) {
      bannerList.clear();
      data.forEach((v) {
        bannerList.add(BannerListEntity().fromJson(v));
      });
      setState(() {});
    });

    Net().post(ApiTransaction.collection_product_list, null, success: (data) {
      collectionProductListEntityList.clear();
      data.forEach((v) {
        collectionProductListEntityList.add(CollectionProductListEntity().fromJson(v));
      });
      Future.delayed(Duration(milliseconds: 200), () async {
        size1Controller.forward();
      });
      if (collectionProductListEntityList.length == 0)
        isData = true;
      else
        isData = false;
      setState(() {});
    }, failure: (error) {
      isData = true;
      setState(() {});
    });
  }
}
