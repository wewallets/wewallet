import 'package:flutter/cupertino.dart';
import 'package:mars/wallet/common/component_index.dart';

import '../../routes/user/wallet_management_page.dart';
import 'base_dialog.dart';

class SelectCountryDialog extends StatelessWidget {
  SelectCountryDialog(this.type, this.onPressed, this.list);

  final type;
  final onPressed;
  final List<String> list;

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
              padding: EdgeInsets.only(bottom: dp(20)),
              decoration: BoxDecoration(color: Colours().background, borderRadius: BorderRadius.only(topLeft: Radius.circular(dp(15)), topRight: Radius.circular(dp(15)))),
              child: Column(
                children: [
                  listViewBuilder(
                      isSlide: true,
                      itemCount: list.length,
                      itemBuilder: (contexts, index) {
                        return inkButton(
                          onPressed: () {
                            Navigator.pop(context);
                            if (type == 1)
                              onPressed(index, list[index]);
                            else
                              onPressed(list[index]);
                          },
                          child: Column(
                            children: [
                              Container(
                                  padding: EdgeInsets.only(top: dp(20), bottom: dp(20)),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${list[index]}', style: TextStyles().textTheme16.copyWith(fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                              Lines().line,
                            ],
                          ),
                        );
                      }),
                  inkButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(top: dp(20), bottom: dp(20)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('取消', style: TextStyles().textBlack16.copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ))),
                ],
              ))
        ],
      ),
    ));
  }
}
