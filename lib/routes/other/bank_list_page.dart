import 'package:mars/common/transaction_component_index.dart';
import 'package:mars/models/bank_card_info_entity.dart';

class BankListPage extends StatefulWidget {
  @override
  _BankListPageState createState() => _BankListPageState();
}

class _BankListPageState extends State<BankListPage> {
  String orderId = '';

  TextEditingController amountController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LayoutUtil.getAppBar(context, '${getString().pooltxt27}'),
      body: Container(
        margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(color: Colours.white, borderRadius: BorderRadius.all(Radius.circular(10))),
        child: bankCardInfoList.length == 0
            ? buildLoadingShadeCustom()
            : listViewBuilder(
                itemCount: bankCardInfoList.length,
                itemBuilder: (context, index) {
                  return _getItem(bankCardInfoList[index]);
                }),
      ),
    );
  }

  _getItem(BankCardInfoEntity bankCardInfoEntity) {
    return inkButton(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenUtil().setWidth(90),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${bankCardInfoEntity.bankName}',
                    style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack, fontWeight: FontWeight.bold),
                  ),
                  LoadImage(
                    'youjiantou',
                    width: ScreenUtil().setWidth(44),
                    height: ScreenUtil().setWidth(44),
                  )
                ],
              ),
            ),
            Divider(
              color: Colours.colorFFEFEFEF,
              height: ScreenUtil().setWidth(1),
            )
          ],
        ),
        onPressed: () {
          Navigator.pop(context);
          EventBus().send('bankCardInfoEntity', bankCardInfoEntity);
        });
  }

  List<BankCardInfoEntity> bankCardInfoList = [];

  _getData() {
    Net().post(ApiTransaction.bank_list, null, success: (data) {
      bankCardInfoList.clear();
      data.forEach((v) {
        bankCardInfoList.add(BankCardInfoEntity().fromJson(v));
      });
      setState(() {});
    });
  }
}
