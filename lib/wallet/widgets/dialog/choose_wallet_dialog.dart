import 'package:flutter/cupertino.dart';
import 'package:mars/wallet/common/component_index.dart';
import 'package:mars/wallet/widgets/dialog/select_country_dialog.dart';

import '../../mobels/category_list_entity.dart';
import '../../mobels/wallet_entity.dart';
import '../../routes/user/wallet_management_page.dart';
import 'base_dialog.dart';

class ChooseWalletDialog extends StatefulWidget {
  @override
  _ChooseWalletDialogState createState() => _ChooseWalletDialogState();
}

class _ChooseWalletDialogState extends State<ChooseWalletDialog> {
  int classType = 0;
  List<CategoryListEntity> categoryList = [];
  List<WalletEntity> walletList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BaseDialog(
      entryAnimation: EntryAnimation.BOTTOM,
      width: double.infinity,
      height: double.infinity,
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              decoration: BoxDecoration(color: Colours().background, borderRadius: BorderRadius.only(topLeft: Radius.circular(dp(15)), topRight: Radius.circular(dp(15)))),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colours().white, borderRadius: BorderRadius.only(topLeft: Radius.circular(dp(15)), topRight: Radius.circular(dp(15)))),
                    child: Row(
                      children: [
                        Text('选择钱包', style: TextStyles().textBlack16),
                        Expanded(child: Container()),
                        inkButton(
                            child: LoadImage('dialog_close', width: dp(20), height: dp(20)),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                    padding: EdgeInsets.all(dp(20)),
                  ),
                  Lines().line,
                  Container(child: WalletManagementPage(Bundle()..putInt('type', 1)), height: dp(480)),

                  // buildContent(context),
                ],
              ))
        ],
      ),
    ));
  }
}
