import 'package:mars/common/transaction_component_index.dart';

//修改矿工列表的备注
class ModificationRemarksPage extends StatefulWidget {
  final Bundle bundle;

  ModificationRemarksPage(this.bundle);

  @override
  _ModificationRemarksPageState createState() => _ModificationRemarksPageState();
}

class _ModificationRemarksPageState extends State<ModificationRemarksPage> {
  TextEditingController nameController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = widget.bundle.getString('name') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.background,
      appBar: LayoutUtil.getAppBar(context, '备注矿工'),
      body: ListView(
        padding: EdgeInsets.only(top: ScreenUtil().setWidth(50), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
        children: [
          Text('矿工名称', style: TextStyles.textBlack12),
          TextField(
            autofocus: true,
            controller: nameController,
            keyboardType: TextInputType.text,
            maxLength: 20,
            textInputAction: TextInputAction.done,
            style: TextStyle(color: Colours.textBlack, fontSize: ScreenUtil().setWidth(36)),
            cursorColor: Colours.textBlack,
            decoration: InputDecoration(counterText: '', border: InputBorder.none, fillColor: Colors.transparent, hintText: '请输入矿工备注名称', hintStyle: TextStyles.textGrey14, prefixStyle: TextStyles.textBlack14),
          ),
          Divider(height: 0, color: Colours.colorEE),
          Gaps.vGap50,
          Buttons.getDetermineButton(
              isUse: true,
              buttonText: '保存',
              voidCallback: () {
                if (nameController.text.length == 0) {
                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '请填写矿工备注名称');
                  return;
                }
                LayoutUtil.showLoadingDialog(context);
                Net().post(ApiTransaction.SET_RMARK, {'address': widget.bundle.getString('address'), 'miner_remark': nameController.text}, success: (data) {
                  LayoutUtil.closeLoadingDialog(context);
                  Navigator.of(context).pop(nameController.text);
                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '修改成功');
                }, failure: (error) {
                  LayoutUtil.closeLoadingDialog(context);
                  Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: '$error');
                });
              }),
        ],
      ),
    );
  }
}
