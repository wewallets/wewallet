import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/public_offering_entity.dart';
import 'package:mars/models/public_offerings_entity.dart';
import 'package:mars/widgets/dialog/input_password_dialog.dart';
import 'package:mars/widgets/dialog/transaction_contract_dialog.dart';

//公募
class PublicOfferingPage extends StatefulWidget {
  @override
  _PublicOfferingPageState createState() => _PublicOfferingPageState();
}

class _PublicOfferingPageState extends State<PublicOfferingPage> {
  PublicOfferingsEntity publicOfferingEntity;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colours.background,
        appBar: LayoutUtil.getAppBar(context, '${getString().gm1}'),
        body: publicOfferingEntity == null
            ? LayoutUtil.getLoadingShadeCustom()
            : Stack(
                children: [
                  ListView(padding: EdgeInsets.only(top: ScreenUtil().setWidth(30), bottom: adaptationDp(20)), children: <Widget>[
                    Row(children: [
                      Gaps.hGap15,
                      LoadAssetImage('logo_x', width: adaptationDp(50)),
                      Gaps.hGap15,
                      Text('${publicOfferingEntity.title}', style: TextStyles.textBlack15),
                      Expanded(child: Container()),
                      // Container(
                      //     decoration: BoxDecoration(color: Color(0x0F1635BB), borderRadius: BorderRadius.circular(adaptationDp(3))),
                      //     padding: EdgeInsets.all(adaptationDp(14)),
                      //     child: Row(children: [
                      //       Text('${getString().gm2}：', style: TextStyles.textBlack12),
                      //       Text('${getStatus()}', style: TextStyles.textBlack12.copyWith(color: Color(0xFF1635BB))),
                      //     ])),
                      // Gaps.hGap15,
                    ]),
                    Gaps.vGap20,
                    Row(children: [
                      Gaps.hGap15,
                      Text('${getString().gm3}：', style: TextStyles.textGrey12),
                      Text('${publicOfferingEntity.authTime}', style: TextStyles.textBlack12),
                      Gaps.hGap15,
                    ]),
                    Gaps.vGap8,
                    Row(children: [
                      Gaps.hGap15,
                      Text('${getString().gm4}：', style: TextStyles.textGrey12),
                      Text('${publicOfferingEntity.productCurrency}', style: TextStyles.textBlack12),
                      Gaps.hGap15,
                    ]),
                    Gaps.vGap8,
                    // Row(children: [
                    //   Gaps.hGap15,
                    //   Text('用户　　：', style: TextStyles.textGrey12),
                    //   Text('${publicOfferingEntity.title}', style: TextStyles.textBlack12),
                    //   Gaps.hGap15,
                    // ]),
                    // Gaps.vGap8,
                    Row(children: [
                      Gaps.hGap15,
                      Text('${getString().gm5}：', style: TextStyles.textGrey12),
                      Text('${publicOfferingEntity.productPeopleEach}', style: TextStyles.textBlack12),
                      Gaps.hGap15,
                    ]),
                    Gaps.vGap15,
                    Container(width: double.infinity, height: adaptationDp(10), color: Color(0xFFF3F3F3)),
                    Gaps.vGap15,
                    Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${getString().gm6}', style: TextStyles.textBlack15)),
                    Gaps.vGap15,
                    Lines.line,
                    Gaps.vGap15,
                    Padding(padding: EdgeInsets.only(left: adaptationDp(15), right: adaptationDp(15)), child: Text('${publicOfferingEntity.explain}', style: TextStyles.textGrey12)),
                    Gaps.vGap15,
                    Lines.line,
                    Gaps.vGap15,
                    Row(
                      children: [
                        Gaps.hGap15,
                        Text('${getString().gm7}', style: TextStyles.textBlack14),
                        Expanded(child: Container()),
                        Text('${publicOfferingEntity.issueTime ?? ''}', style: TextStyles.textGrey14),
                        Gaps.hGap15,
                      ],
                    ),
                    Gaps.vGap15,
                    Lines.line,
                    Gaps.vGap15,
                    Row(
                      children: [
                        Gaps.hGap15,
                        Text('${getString().gm8}', style: TextStyles.textBlack14),
                        Expanded(child: Container()),
                        Text('${publicOfferingEntity.issueTotal ?? ''}', style: TextStyles.textGrey14),
                        Gaps.hGap15,
                      ],
                    ),
                    Gaps.vGap15,
                    Lines.line,
                    Gaps.vGap15,
                    Row(
                      children: [
                        Gaps.hGap15,
                        Text('${getString().gm9}', style: TextStyles.textBlack14),
                        Gaps.hGap30,
                        Expanded(child: Container()),
                        inkButton(
                            child: Text('${publicOfferingEntity.whitepaper ?? ''}', style: TextStyles.textGrey14),
                            onPressed: () {
                              Navigator.pushNamed(context, PageTransactionRouter.webview_page, arguments: Bundle()..putString('titleName', '${getString().gm9}')..putString('url', '${publicOfferingEntity.whitepaper}'));
                            }),
                        Gaps.hGap15,
                      ],
                    ),
                    Gaps.vGap15,
                    Lines.line,
                    Gaps.vGap15,
                    Row(
                      children: [
                        Gaps.hGap15,
                        Text('${getString().gm10}', style: TextStyles.textBlack14),
                        Expanded(child: Container()),
                        Text('${publicOfferingEntity.website ?? ''}', style: TextStyles.textGrey14),
                        Gaps.hGap15,
                      ],
                    ),
                    Gaps.vGap15,
                    Lines.line,
                    Gaps.vGap15,
                    Row(
                      children: [
                        Gaps.hGap15,
                        Text('${getString().gm11}', style: TextStyles.textBlack14),
                        Expanded(child: Container()),
                        Text('${publicOfferingEntity.address ?? ''}', style: TextStyles.textGrey14),
                        Gaps.hGap15,
                      ],
                    ),
                    Gaps.vGap15,
                    Lines.line,
                  ]),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: adaptationDp(15), left: adaptationDp(15), right: adaptationDp(15)),
                        child: getButton(),
                      )),
                ],
              ));
  }

  getStatus() {
    if (publicOfferingEntity.productStatus == '0') {
      return '${getString().gm12}';
    } else if (publicOfferingEntity.productStatus == '1') {
      return '${getString().gm13}';
    } else if (publicOfferingEntity.productStatus == '2') {
      return '${getString().gm14}';
    } else {
      return '';
    }
  }

  getButton() {
    if (publicOfferingEntity.isBuy == '1') {
      return Buttons.getDetermineButton(
          isUse: true,
          buttonText: '${getString().qd}(${publicOfferingEntity.orderPayAmount})',
          voidCallback: () {
            showDialog(
                context: context,
                builder: (builder) {
                  return TransactionContractDialog(publicOfferingEntity, () {
                    Navigator.pop(context);

                    showDialog(
                        context: context,
                        builder: (_) => InputPasswordDialog((data) {
                              if (data == GlobalTransaction.walletPassword) {
                                submit();
                              } else {
                                Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '${getString().nsrdmmcw}');
                              }
                            }));
                  });
                });
          });
    } else if (publicOfferingEntity.isBuy == '2') {
      return Buttons.getDetermineButton(isUse: false, buttonText: '${getString().gm23}');
    } else if (publicOfferingEntity.isBuy == '3') {
      return Buttons.getDetermineButton(isUse: false, buttonText: '${getString().gm15}');
    } else {
      return Buttons.getDetermineButton(isUse: false, buttonText: '${getString().gm16}');
    }
  }

  submit() {
    showLoadingContextDialog(context);
    Net().post(ApiTransaction.product_buy, {}, success: (data) {
      getData();
      closeLoadingContextDialog(context);
      showToast('${getString().zfcgclz}');
      if (mounted) setState(() {});
    }, failure: (error) {
      closeLoadingContextDialog(context);
      showToast('$error');
    });
  }

  getData() {
    Net().post(ApiTransaction.product_detail, {}, success: (data) {
      publicOfferingEntity = PublicOfferingsEntity().fromJson(data);
      if (mounted) setState(() {});
    });
  }
}
