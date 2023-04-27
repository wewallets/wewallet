import 'package:mars/models/Wallet_Pledge_list.dart';
import 'package:mars/wallet/common/component_index.dart';
import '../../../common/utils/num_util.dart';
import '../../widgets/dialog/select_country_dialog.dart';

class PledgePage extends StatefulWidget {
  final Bundle bundle;

  PledgePage(this.bundle);

  @override
  _PledgePageState createState() => _PledgePageState();
}

class _PledgePageState extends BaseState<PledgePage> {
  TextEditingController nameController = TextEditingController();
  bool isFreeze = true;
  String total = '';
  List<WalletPledgeList> list = [];
  String day = '';
  int listIndex = 0;

  @override
  Widget get appBar => getAppBar(widget.bundle.getInt('type') == 0 ? '定期质押' : '活期质押', actions: [
        inkButton(
            onPressed: () {
              navigateTo(PageWalletRouter.my_pledge_page);
            },
            child: Text('我的质押', style: TextStyles().textBlack14)),
        Gaps.hGap15,
      ]);

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 0), () async {
      getData();
    });
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(dp(18)),
          width: double.infinity,
          height: dp(100),
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(getImgPath('dqzy_bg')), fit: BoxFit.fill)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('全网定期质押总量', style: TextStyles().textWhite14),
            Gaps.vGap8,
            Text('$total', style: TextStyles().textWhite23),
          ])),
      widget.bundle.getInt('type') == 0 ? buildType1 : buildType2,
      Expanded(child: Container()),
      Buttons.getDetermineButton(
          buttonText: widget.bundle.getInt('type') == 0 ? '确认提交' : (isFreeze ? '确认冻结' : '确认解冻'),
          margin: EdgeInsets.all(dp(15)),
          onPressed: () {
            submit();
          }),
      Gaps.vGap40,
    ]);
  }

  get buildType1 {
    return Column(children: [
      inkButton(
          onPressed: () {
            List<String> dayList = [];
            for (int i = 0; i < list.length; i++) dayList.add('${list[i].day}');

            showDialog(
                context: context,
                builder: (context) => SelectCountryDialog(1, (index, data) async {
                      listIndex = index;
                      day = data;
                      setState(() {});
                    }, dayList));
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
            padding: EdgeInsets.all(dp(15)),
            margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
            child: Row(
              children: [
                Text('投资周期：', style: TextStyles().textBlack14),
                Expanded(child: Container()),
                Text('$day天', style: TextStyles().textTheme14),
                LoadImage('dqzy_xh', width: dp(20), height: dp(20)),
              ],
            ),
          )),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
        padding: EdgeInsets.all(dp(15)),
        margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
        child: Row(
          children: [
            Text('收益率：', style: TextStyles().textBlack14),
            Expanded(child: Container()),
            Text('${list.length == 0 ? '' : list[listIndex].rate}%', style: TextStyles().textTheme14),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white, border: Border.all(width: 0.5, color: Colours().themeColor)),
        padding: EdgeInsets.only(left: dp(15), right: dp(15)),
        height: dp(50),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              keyboardType: TextInputType.number,
              controller: nameController,
              style: TextStyles().textBlack14,
              decoration: InputDecoration(border: InputBorder.none, counterText: '', fillColor: Colors.transparent, hintText: '投资数量', hintStyle: TextStyles().textGrey14),
            )),
            inkButton(
                onPressed: () {
                  nameController.text = NumUtil.formatNum(Global.getAssetsWalletInfo('YISE').value, 5).toString();
                  setState(() {});
                },
                child: Text('YISE', style: TextStyles().textTheme14)),
          ],
        ),
      ),
      Gaps.vGap15,
      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        Gaps.hGap20,
        Text('可用 YISE ', style: TextStyles().textGrey12),
        Text('${NumUtil.formatNum(Global.getAssetsWalletInfo('YISE').value, 5)}', style: TextStyles().textTheme12),
        Expanded(child: Container()),
        Text('投资限额 ${list.length == 0 ? '' : list[listIndex].payMin}-${list.length == 0 ? '' : list[listIndex].payMax}', style: TextStyles().textGrey12),
        Gaps.hGap20,
      ]),
    ]);
  }

  get buildType2 {
    return Column(children: [
      Gaps.vGap15,
      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(30)), color: Colours().white),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inkButton(
                  onPressed: () {
                    isFreeze = true;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(30)), color: isFreeze ? Colours().themeColor : Colours().white),
                    padding: EdgeInsets.only(left: dp(30), right: dp(30), top: dp(15), bottom: dp(15)),
                    child: Text('冻结', style: isFreeze ? TextStyles().textWhite14 : TextStyles().textBlack14),
                  )),
              inkButton(
                onPressed: () {
                  isFreeze = false;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(30)), color: isFreeze ? Colours().white : Colours().themeColor),
                  padding: EdgeInsets.only(left: dp(30), right: dp(30), top: dp(15), bottom: dp(15)),
                  child: Text('解冻', style: !isFreeze ? TextStyles().textWhite14 : TextStyles().textBlack14),
                ),
              ),
            ],
          ),
        ),
      ]),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
        padding: EdgeInsets.all(dp(15)),
        margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
        child: Row(
          children: [
            Text('收益率：', style: TextStyles().textBlack14),
            Expanded(child: Container()),
            Text('${list.length == 0 ? '' : list[listIndex].rate}%', style: TextStyles().textTheme14),
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white, border: Border.all(width: 0.5, color: Colours().themeColor)),
        padding: EdgeInsets.only(left: dp(15), right: dp(15)),
        height: dp(50),
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(left: dp(15), right: dp(15), top: dp(15)),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              keyboardType: TextInputType.number,
              controller: nameController,
              style: TextStyles().textBlack14,
              decoration: InputDecoration(border: InputBorder.none, counterText: '', fillColor: Colors.transparent, hintText: '投资数量', hintStyle: TextStyles().textGrey14),
            )),
            Text('YISE', style: TextStyles().textTheme14),
          ],
        ),
      ),
      Gaps.vGap15,
      Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
        Gaps.hGap20,
        Text('${isFreeze ? '可用YISE' : ''}  ', style: TextStyles().textGrey12),
        Text('${isFreeze ? Global.getAssetsWalletInfo('YISE').value : ''}', style: TextStyles().textTheme12),
        Expanded(child: Container()),
        Text('提示：灵活应用，随用随取', style: TextStyles().textGrey12),
        Gaps.hGap20,
      ]),
    ]);
  }

  getData() {
    showLoadingDialog();

  }

  submit() {

  }
}
