import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mars/models/bank_card_info_entity.dart';
import 'package:mars/widgets/loading_shade_custom.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mars/common/transaction_component_index.dart';

class ConfirmRechargePage extends StatefulWidget {
  final Bundle bundle;

  ConfirmRechargePage(this.bundle);

  @override
  _ConfirmRechargePageState createState() => _ConfirmRechargePageState();
}

class _ConfirmRechargePageState extends State<ConfirmRechargePage> {
  String rechargeAmount = '';
  BankCardInfoEntity bankCardInfoEntity;

  TextEditingController amountController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  String image;

  @override
  void initState() {
    super.initState();
    rechargeAmount = widget.bundle.getString('rechargeAmount');
    bankCardInfoEntity = widget.bundle.getObject('bankCardInfoEntity');
    // _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: LayoutUtil.getAppBar(context, '${getString().pooltxt43}'),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(119), left: ScreenUtil().setWidth(30), right: ScreenUtil().setWidth(30), top: ScreenUtil().setWidth(61)),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${getString().pooltxt28}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                    ),
                    Expanded(
                        child: Container(
                      width: ScreenUtil().setWidth(500),
                      child: Text(
                        '${rechargeAmount}${getString().pooltxt29}',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                      ),
                    )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(40), bottom: ScreenUtil().setWidth(30)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                ),
                Row(
                  children: [
                    Text(
                      '${getString().pooltxt30}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                    ),
                    Expanded(
                        child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bankCardInfoEntity?.bankName ?? '',
                            style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            child: Container(
                              height: ScreenUtil().setWidth(50),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(border: Border.all(color: Colours.colorFFAF6969, width: ScreenUtil().setWidth(1)), borderRadius: BorderRadius.all(Radius.circular(10))),
                              width: ScreenUtil().setWidth(90),
                              child: Text(
                                '${getString().pooltxt31}',
                                style: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colours.colorFFAF6969),
                              ),
                            ),
                            onTap: () {
                              Clipboard.setData(new ClipboardData(text: bankCardInfoEntity?.bankName ?? ''));
                              showToast('${getString().fzcg}');
                            },
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${getString().pooltxt32}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                    ),
                    Expanded(
                        child: Container(
                      width: ScreenUtil().setWidth(500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            bankCardInfoEntity?.bankAccount ?? '',
                            style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                          ),
                          Expanded(child: Container()),
                          GestureDetector(
                            child: Container(
                              height: ScreenUtil().setWidth(50),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(border: Border.all(color: Colours.colorFFAF6969, width: ScreenUtil().setWidth(1)), borderRadius: BorderRadius.all(Radius.circular(10))),
                              width: ScreenUtil().setWidth(90),
                              child: Text(
                                '${getString().pooltxt31}',
                                style: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colours.colorFFAF6969),
                              ),
                            ),
                            onTap: () {
                              Clipboard.setData(new ClipboardData(text: bankCardInfoEntity?.bankAccount ?? ''));
                              showToast('${getString().fzcg}');
                            },
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(30), bottom: ScreenUtil().setWidth(30)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${getString().pooltxt32}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                    ),
                    Expanded(
                      child: Container(
                          width: ScreenUtil().setWidth(500),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                bankCardInfoEntity?.bankUser ?? '',
                                style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                              ),
                              Expanded(child: Container()),
                              GestureDetector(
                                child: Container(
                                  height: ScreenUtil().setWidth(50),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(border: Border.all(color: Colours.colorFFAF6969, width: ScreenUtil().setWidth(1)), borderRadius: BorderRadius.all(Radius.circular(10))),
                                  width: ScreenUtil().setWidth(90),
                                  child: Text(
                                    '${getString().pooltxt31}',
                                    style: TextStyle(fontSize: ScreenUtil().setSp(26), color: Colours.colorFFAF6969),
                                  ),
                                ),
                                onTap: () {
                                  Clipboard.setData(new ClipboardData(text: bankCardInfoEntity?.bankUser ?? ''));
                                  showToast('${getString().fzcg}');
                                },
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                ),
                Container(
                  height: ScreenUtil().setWidth(110),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getString().pooltxt33}',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                      ),
                      Expanded(
                          child: Container(
                        width: ScreenUtil().setWidth(500),
                        child: TextField(
                          autofocus: false,
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colours.themeColor, fontSize: ScreenUtil().setWidth(30)),
                          cursorColor: Colours.themeColor,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().pooltxt34}', hintStyle: TextStyle(color: Colours.colorFFA8A8A8, fontSize: ScreenUtil().setWidth(30))),
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(40)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                ),
                Text(
                  '${getString().pooltxt36}',
                  style: TextStyle(fontSize: ScreenUtil().setSp(30), color: ColorsUtil.hexColor(0x333333)),
                ),
                Padding(padding: EdgeInsets.only(top: ScreenUtil().setWidth(30))),
                Wrap(
                  children: <Widget>[image == null ? _uploadItem : getVoucherImgItem()],
                  spacing: ScreenUtil().setWidth(15),
                  runSpacing: ScreenUtil().setWidth(15),
                ),
                Container(
                  margin: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                ),
                Container(
                  height: ScreenUtil().setWidth(110),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${getString().pooltxt44}',
                        style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                      ),
                      Expanded(
                          child: Container(
                        width: ScreenUtil().setWidth(500),
                        child: TextField(
                          autofocus: false,
                          controller: amountController,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(color: Colours.themeColor, fontSize: ScreenUtil().setWidth(30)),
                          cursorColor: Colours.themeColor,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(border: InputBorder.none, fillColor: Colors.transparent, hintText: '${getString().pooltxt44}', hintStyle: TextStyle(color: Colours.colorFFA8A8A8, fontSize: ScreenUtil().setWidth(30))),
                        ),
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(40)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${getString().pooltxt37}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(30), color: Colours.textBlack),
                    ),
                    GestureDetector(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            rechargeData.length > 0 ? rechargeData : '${getString().pooltxt38}',
                            style: TextStyle(fontSize: ScreenUtil().setSp(30), color: rechargeData.length > 0 ? Colours.textBlack : Colours.colorFFA8A8A8),
                          ),
                          LoadImage(
                            'youjiantou',
                            width: ScreenUtil().setWidth(44),
                            height: ScreenUtil().setWidth(44),
                          )
                        ],
                      ),
                      onTap: () {
                        DatePicker.showDateTimePicker(context, showTitleActions: true, onChanged: (date) {}, onConfirm: (date) {
                          print('confirm $date');
                          rechargeData = date.toString().split('.')[0];
                          setState(() {});
                        }, currentTime: DateTime.now(), locale: LocaleType.zh);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(40)),
                  color: Colours.colorEE,
                  height: ScreenUtil().setWidth(1),
                )
              ],
            ),
            Positioned(
              width: MediaQuery.of(context).size.width,
              bottom: ScreenUtil().setWidth(30),
              child: _bottomOperation,
            )
          ],
        ));
  }

  String rechargeData = '';

  Widget getVoucherImgItem() {
    double runWidth = (MediaQuery.of(context).size.width - ScreenUtil().setWidth(90)) / 3;
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: LoadImage(
        'http:$image',
        width: runWidth,
        height: runWidth,
        fit: BoxFit.fill,
      ),
    );
  }

  Widget get _uploadItem {
    double runWidth = (MediaQuery.of(context).size.width - ScreenUtil().setWidth(90)) / 3;
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: runWidth,
        height: runWidth,
        decoration: BoxDecoration(border: Border.all(color: Colours.colorFFA8A8A8, width: ScreenUtil().setWidth(1)), borderRadius: BorderRadius.all(Radius.circular(5))),
        child: LoadAssetImage(
          'icon_photo',
          width: ScreenUtil().setWidth(45),
          height: ScreenUtil().setWidth(44),
          fit: BoxFit.fill,
          color: Colours.themeColor,
        ),
      ),
      onTap: () {
        loadAssets();
        // _uploadVoucher();
      },
    );
  }

  // final picker = ImagePicker();

  Widget get _bottomOperation {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: GestureDetector(
        onTap: () {
          submit();
        },
        child: Container(
          alignment: Alignment.center,
          height: ScreenUtil().setWidth(89),
          decoration: BoxDecoration(color: Colours.colorFFAF6969, borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Text(
            '${getString().pooltxt39}',
            style: TextStyle(fontSize: ScreenUtil().setSp(30), color: ColorsUtil.hexColor(0xffffff)),
          ),
        ),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        selectedAssets: resultList,
        cupertinoOptions: CupertinoOptions(
          takePhotoIcon: "chat",
          doneButtonTitle: "Fatto",
        ),
        materialOptions: MaterialOptions(
          actionBarColor: "#d51885",
          actionBarTitle: "${getString().pooltxt40}",
          allViewTitle: "All Photos",
          useDetailsView: true,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {}

    _uplodImg(resultList[0]);
  }

  var setStateStateful;

  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  _uplodImg(Asset asset) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return StatefulBuilder(builder: (context1, setStateStateful) {
            this.setStateStateful = setStateStateful;
            return Scaffold(
                backgroundColor: Colours.transparent,
                body: LoadingShadeCustom(
                  msg: '${getString().pooltxt41}',
                  loading: true,
                  child: Container(),
                  textColor: ColorsUtil.hexColor(0x333333),
                ));
          });
        });
    final filename = asset.name;
    var bytes = await asset.getByteData(quality: 50);
    String dir = (await getTemporaryDirectory()).path;
    File file = await writeToFile(bytes, '$dir/$filename');

    Net().uploading(ApiTransaction.uplod_img, FormData.fromMap({"file": await MultipartFile.fromFile(file.path, filename: file.path.substring(file.path.lastIndexOf('/') + 1))}), success: (data) async {
      image = data;
      Navigator.of(context).pop();
      setStateStateful(() {});
      setState(() {});
      showToast('${getString().pooltxt42}');
    }, failure: (error) {
      Navigator.of(context).pop();
      Fluttertoast.showToast(gravity:ToastGravity.CENTER,msg: error.toString());
    });
  }

  submit() {
    if (nameController.text == '') {
      showToast('${getString().pooltxt34}');
      return;
    }
    if (amountController.text == '') {
      showToast('${getString().pooltxt44}');
      return;
    }
    if (rechargeData == '') {
      showToast('${getString().pooltxt45}');
      return;
    }
    LayoutUtil.showLoadingDialog(context);
    Net().post(ApiTransaction.recharge_add, {
      'bank_id': '${bankCardInfoEntity.bankId}',
      'recharge_amount': rechargeAmount,
      'recharge_name': nameController.text,
      'recharge_img': image,
      'recharge_number': amountController.text,
      'recharge_time': rechargeData,
    }, success: (data) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('${getString().tjcgddsh}');
      Navigator.pop(context);
    }, failure: (error) {
      LayoutUtil.closeLoadingDialog(context);
      showToast('$error');
    });
  }
}
