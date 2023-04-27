import 'package:mars/common/transaction_component_index.dart';

class EcologyPage extends StatefulWidget {
  @override
  _EcologyPageState createState() => _EcologyPageState();
}

class _EcologyPageState extends State<EcologyPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.zero, children: [
      buildTopContent(),
      Padding(padding: EdgeInsets.all(adaptationDp(15)), child: Text('${getString().stwb3}', style: TextStyles.textGrey14)),
      buildEcologyText(getString().stwb4, getString().stwb5, getString().stwb6, 'ep213', true, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail12_page);
      }),
      buildEcologyText(getString().zf79, getString().xtj30, getString().xtj31, 'ep212', false, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail13_page);
      }),
      buildEcologyText(getString().stwb7, getString().stwb8, getString().stwb9, 'ep32', true, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail2_page);
      }),
      buildEcologyText('RISE EARN', getString().stwb11, getString().stwb12, 'ep58', false, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail4_page);
      }),
      buildEcologyText(getString().stwb13, getString().stwb14, getString().stwb15, 'ep60', true, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail1_page);
      }),
      buildEcologyText(getString().stwb16, getString().stwb17, getString().stwb18, 'ep46', false, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail3_page);
      }),
      buildEcologyText(getString().stwb19, getString().stwb20, getString().stwb21, 'ep48', true, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail5_page);
      }),
      buildEcologyText(getString().stwb22, getString().stwb23, getString().stwb24, 'ep59', false, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail6_page);
      }),
      buildEcologyText(getString().stwb25, getString().stwb26, getString().stwb27, 'ep50', true, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail9_page);
      }),
      buildEcologyText(getString().stwb28, getString().stwb29, getString().stwb30, 'ep44', false, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail10_page);
      }),
      buildEcologyText(getString().stwb31, getString().stwb32, getString().stwb33, 'ep51', true, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail11_page);
      }),
      buildEcologyText(getString().stwb34, getString().stwb35, getString().stwb36, 'ep33', false, () {
        navigatorTransactionContextPush(context, PageTransactionRouter.ecology_detail7_page);
      }),

    ]);
  }

  buildTopContent() {
    return Stack(alignment: Alignment.topLeft, children: [
      LoadImage('ep47', height: adaptationDp(153), width: double.infinity),
      Padding(
          padding: EdgeInsets.only(left: adaptationDp(15), top: adaptationDp(50)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [Text('${getString().stwb1}', style: TextStyles.textWhite18), Text('${getString().stwb2}', style: TextStyles.textWhite18)])),
    ]);
  }

  buildEcologyText(type, title, content, image, color, onPressed) {
    return inkButton(
        onPressed: onPressed,
        child: Padding(
            padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15), bottom: adaptationDp(15)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)), color: !color ? Colours.themeColor : Colours.colorFFC939F3),
                  padding: EdgeInsets.only(top: adaptationDp(1), bottom: adaptationDp(2), left: adaptationDp(2), right: adaptationDp(2)),
                  child: Text(type, style: TextStyles.textWhite12)),
              Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colours.white),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          LoadImage(image, width: adaptationDp(100)),
                          LoadImage('ep41', width: adaptationDp(20)),
                          Gaps.hGap10,
                        ]),
                      ),
                      Row(children: [
                        Padding(
                            padding: EdgeInsets.only(top: adaptationDp(10), bottom: adaptationDp(10), left: adaptationDp(10), right: adaptationDp(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(title, style: TextStyles.textBlack14),
                                Gaps.vGap2,
                                Text(content, style: TextStyles.textGrey12),
                              ],
                            )),
                      ]),
                    ],
                  )),
            ])));
  }
}
