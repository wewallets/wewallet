import 'package:azlistview/azlistview.dart';
import 'package:mars/wallet/common/component_index.dart';

import '../../../routes/other/select_currency_page.dart';

class SelectCurrencyPage extends StatefulWidget {
  @override
  _SelectCurrencyPageState createState() => _SelectCurrencyPageState();
}

class _SelectCurrencyPageState extends BaseState<SelectCurrencyPage> {
  List<CityModel> cityList = [];
  String keyword;
  int type = 0;

  @override
  Widget get appBar => getAppBar('${getString().xzbz}', actions: []);

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget buildContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: AzListView(
          data: cityList,
          itemCount: cityList.length,
          itemBuilder: (BuildContext context, int index) {
            CityModel model = cityList[index];
            return InkWell(
                onTap: () {
                  Navigator.of(context).pop(model.name);
                },
                child: Column(
                  children: [
                    Container(
                      child: Text(model.name, style: TextStyles().textBlack14),
                      height: ScreenUtil().setWidth(100),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(height: ScreenUtil().setWidth(2), color: Colours().colorEE),
                  ],
                ));
          },
          physics: BouncingScrollPhysics(),
          indexBarOptions: IndexBarOptions(
            needRebuild: true,
            ignoreDragCancel: true,
            downTextStyle: TextStyles().textWhite12,
            textStyle: TextStyles().textBlack12,
            downItemDecoration: BoxDecoration(shape: BoxShape.circle, color: Colours().themeColor),
            indexHintWidth: 120 / 2,
            indexHintHeight: 100 / 2,
            indexHintAlignment: Alignment.centerRight,
            indexHintChildAlignment: Alignment(-0.25, 0.0),
            indexHintOffset: Offset(-20, 0),
          ),
          susItemHeight: ScreenUtil().setWidth(80),
        ))
      ],
    );
  }

  getData() {
    Global.getCurrencyList().forEach((element) {
      cityList.add(CityModel(name: element.currencyName, tagIndex: element.currencyName.substring(0, 1)));
    });
  }
}
