import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:mars/common/transaction_component_index.dart';

import '../../common/whiteBase/base_state.dart';

//选择币种
class SelectCurrencyWhitePage extends StatefulWidget {
  final Bundle bundle;

  SelectCurrencyWhitePage(this.bundle);

  @override
  _SelectCurrencyWhitePageState createState() => _SelectCurrencyWhitePageState();
}

class _SelectCurrencyWhitePageState extends BaseState<SelectCurrencyWhitePage> {
  List<CityModel> cityList = [];
  List<String> list;
  String keyword;

  @override
  void initState() {
    super.initState();
    if (widget.bundle != null && widget.bundle.isContainsKey('list')) list = widget.bundle.getObject('list');

    getData();
  }

  @override
  Widget get appBar => getAppBar('${getString().xzbz}');

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
                      child: Text(model.name.toUpperCase(), style: TextStyles.textBlack14),
                      height: ScreenUtil().setWidth(79),
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30)),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(height: ScreenUtil().setWidth(1), color: Colours.textGrey6),
                  ],
                ));
          },
          physics: BouncingScrollPhysics(),
          indexBarOptions: IndexBarOptions(
            needRebuild: true,
            ignoreDragCancel: true,
            downTextStyle: TextStyles.textWhite12,
            textStyle: TextStyles.textBlack12,
            downItemDecoration: BoxDecoration(shape: BoxShape.circle, color: Colours.themeColor),
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
    if (widget.bundle != null) {
      list.forEach((element) {
        cityList.add(CityModel(name: element, tagIndex: element.substring(0, 1)));
      });
      if (mounted) setState(() {});
    }
  }
}

class CityModel extends ISuspensionBean {
  String name;
  String tagIndex;

  CityModel({
    this.name,
    this.tagIndex,
  });

  CityModel.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {'name': name};

  @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => json.encode(this);
}
