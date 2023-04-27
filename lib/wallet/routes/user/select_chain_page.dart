import 'package:mars/common/utils/RESUtil.dart';
import 'package:mars/wallet/common/component_index.dart';

import '../../mobels/Network_list.dart';

class SelectChainPage extends StatefulWidget {
  final Bundle bundle;

  SelectChainPage(this.bundle);

  @override
  _SelectChainPageState createState() => _SelectChainPageState();
}

class _SelectChainPageState extends BaseState<SelectChainPage> {
  @override
  Widget get appBar => getAppBar(widget.bundle.getInt('type') == 0 ? '添加钱包' : '导入钱包');

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 0), () async {
      getData();
    });
  }

  @override
  Color get backgroundColor => Color(0xFFF3F6FB);

  @override
  Widget buildContent(BuildContext context) {
    return listViewBuilder(padding: EdgeInsets.only(top: dp(15)), itemCount: Global.networkList.length, itemBuilder: (context, index) => buildItem(index));
  }

  buildItem(item) {
    return inkButton(
        onPressed: () {
          // String data1=RESUtil.decrypt("RqUv5AEt+oYoO7aF1O5cMrNf99T/vuqHEL7Ig9MN98bSvHYgsr2hZed21GWctbCCp0MCSrHod1v/Lt2x3ARTePkJOeBfVt1ginZF30H1fD/eg2pZQJfrKqPweAFnYL5TaXRmNSmB1dTqxRQgapK0h1WnwnlpwSyRuNxVjyYprRNW2s0cxmrTPkAj7SBkR6xzHc3+R/xImH1NREExQCen2cbMFKr/8Ih1j8Whqr+iY2w7COGiGXL9yCw/VX0sBdPyeJmbqQrgO6tkIb8xdYf7Tf37jYfsdHS9H2mNuFXb7wt0JmCDmpGGt6CFhr6MWLHd37UIYwwLveaCR+pk08nsZQ==");
          //
          // String data2=RESUtil.decrypt("R5T2feypNo3K5DGBlqY1jgp7NYxF1m6dO/US/inx3tSmyggFbeN18B0f17BtXb8Kc7LiBxicB6chEP5xujLX9RNSovjzvzUaW+Zv9fa187ceL9UNI1213nNzWH+poyfO5k4131nM6yRqk+R98jLZ/XLF4KafbDrwNIVzGbakRiaw7Ain/5CaQ/Cz3F90e5zQMNglWWsIVYKe2lpz7Q8qRjTxjUzckoOlp3FIAAEyg7HTL4qydP23G/CES41uoZ2HQ3Ob/euU7fIIhXyNI5/1vYpHW0HIDvCZNCyb09syf7YR54A0y+tWXWVYQCumk5bbz7NzyF5vZWEpJp6Y7F8Ddw==");
          //
          // String data3=RESUtil.encryption(data1);
          // String data4=RESUtil.encryption(data2);

          if (widget.bundle.getInt('type') == 0)
            navigateTo(PageWalletRouter.create_wallet_page, bundle: Bundle()..putString('network', Global.networkList[item].name));
          else
            navigateTo(PageWalletRouter.import_wallet_page, bundle: Bundle()..putString('network', Global.networkList[item].name));
        },
        child: Container(
          margin: EdgeInsets.only(left: dp(15), right: dp(15), bottom: dp(15)),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(dp(12)), color: Colours().white),
          padding: EdgeInsets.all(dp(15)),
          child: Row(
            children: [
              LoadImage('${Global.networkList[item].name.toLowerCase()}', width: dp(50), height: dp(50)),
              Gaps.hGap10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${Global.networkList[item].name}', style: TextStyles().textBlack16),
                  Gaps.vGap2,
                  // Text('专项优化，极速加载。', style: TextStyles().textGrey12),
                ],
              ),
              Expanded(child: Container()),
              LoadImage('icon_arrow_right', width: dp(20), height: dp(20)),
            ],
          ),
        ));
  }

  getData() {
    showLoadingDialog();

  }
}
