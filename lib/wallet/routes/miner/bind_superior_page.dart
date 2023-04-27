import 'package:mars/wallet/common/component_index.dart';

class BindSuperiorPage extends StatefulWidget {
  final Bundle bundle;

  BindSuperiorPage(this.bundle);

  @override
  _BindSuperiorPageState createState() => _BindSuperiorPageState();
}

class _BindSuperiorPageState extends BaseState<BindSuperiorPage> {
  TextEditingController nameController = TextEditingController();
  bool isFreeze = true;

  @override
  Widget get appBar => getAppBar('绑定上级');

  @override
  bool get resizeToAvoidBottomInset => false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(children: [
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
              keyboardType: TextInputType.emailAddress,
              controller: nameController,
              style: TextStyles().textBlack14,
              decoration: InputDecoration(border: InputBorder.none, counterText: '', fillColor: Colors.transparent, hintText: '请输入上级推荐码', hintStyle: TextStyles().textGrey14),
            )),
          ],
        ),
      ),
      Padding(padding: EdgeInsets.only(top: dp(5), left: dp(15), right: dp(15)), child: Text('提示：上级只能绑定一次，不能修改：请仔细核对无误在提交', style: TextStyles().textBlack14.copyWith(color: Color(0xFFEA4B4B)))),
      Expanded(child: Container()),
      Buttons.getDetermineButton(
          buttonText: '确认提交',
          margin: EdgeInsets.all(dp(15)),
          onPressed: () {
            getData();
          }),
      Gaps.vGap40,
    ]);
  }

  getData() {
    if (nameController.text.length == 0) {
      showToast('请输入上级推荐码');
      return;
    }
    showLoadingDialog();

  }
}
