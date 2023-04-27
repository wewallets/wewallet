import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mars/wallet/common/storage_manager.dart';
import 'package:mars/wallet/common/theme_helper.dart';
import 'package:mars/wallet/common/utils/spUtil.dart';

//const Color(0xFF5394FF),

class ThemeModel with ChangeNotifier {
  static const kThemeColorIndex = 'kThemeColorIndex';
  static const kThemeUserDarkMode = 'kThemeUserDarkMode';
  static const kFontIndex = 'kFontIndex';

  static const fontValueList = ['system', 'kuaile'];

  /// 用户选择的明暗模式
  bool _userDarkMode;

  /// 当前主题颜色
  MaterialColor _themeColor;

  /// 当前字体索引
  int _fontIndex;

  ThemeModel() {
    /// 用户选择的明暗模式
    _userDarkMode = SpWalletUtil.getBool(kThemeUserDarkMode) ?? false;

    /// 获取主题色
    _themeColor = Colors.primaries[SpWalletUtil.getInt(kThemeColorIndex) ?? 5];
  }

  int get fontIndex => _fontIndex;

  /// 切换指定色彩
  ///
  /// 没有传[brightness]就不改变brightness,color同理
  void switchTheme({bool userDarkMode, MaterialColor color}) {
    _userDarkMode = userDarkMode ?? _userDarkMode;
    _themeColor = color ?? _themeColor;
    notifyListeners();
    saveTheme2Storage(_userDarkMode, _themeColor);
  }

  /// 随机一个主题色彩
  ///
  /// 可以指定明暗模式,不指定则保持不变
  void switchRandomTheme({Brightness brightness}) {
    int colorIndex = Random().nextInt(Colors.primaries.length - 1);
    switchTheme(
      userDarkMode: Random().nextBool(),
      color: Colors.primaries[colorIndex],
    );
  }

  /// 根据主题 明暗 和 颜色 生成对应的主题
  /// [dark]系统的Dark Mode
  themeData({bool platformDarkMode: false}) {
    var isDark = platformDarkMode || _userDarkMode;
    Brightness brightness = isDark ? Brightness.dark : Brightness.light;

    var themeColor = Color(0xFF05C160);
    var accentColor = isDark ? themeColor : _themeColor;

    var themeData = ThemeData(brightness: brightness, primaryColorBrightness: Brightness.dark, accentColorBrightness: Brightness.dark, primarySwatch: _themeColor, accentColor: accentColor);
    themeData = themeData.copyWith(
      brightness: brightness,
      accentColor: accentColor,
      backgroundColor: isDark ? Color(0xFF111111) : Color(0xFFFFFFFF),
      cupertinoOverrideTheme: CupertinoThemeData(primaryColor: themeColor, brightness: brightness),
      appBarTheme: themeData.appBarTheme.copyWith(elevation: 0),
      splashColor: themeColor.withAlpha(50),
      hintColor: themeData.hintColor.withAlpha(90),
      errorColor: Colors.red,
      textTheme: themeData.textTheme,
      toggleableActiveColor: accentColor,
      inputDecorationTheme: ThemeHelper.inputDecorationTheme(themeData),
    );
    return themeData;
  }

  /// 数据持久化到shared preferences
  saveTheme2Storage(bool userDarkMode, MaterialColor themeColor) async {
    var index = Colors.primaries.indexOf(themeColor);
    await Future.wait([SpWalletUtil.putBool(kThemeUserDarkMode, userDarkMode), SpWalletUtil.putInt(kThemeColorIndex, index)]);
  }
}
