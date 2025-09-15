import 'package:flutter/material.dart';
import 'package:note_app/config/theme/base_theme_data.dart';

enum ThemeType { light, dark }

abstract class BaseAppTheme<A extends BaseThemeData, B extends BaseThemeData> {
  A get lightTheme;

  B get darkTheme;

  String get fontFamily => 'Mali';

  late final ThemeData _lightTheme = ThemeData(
    primaryColor: lightTheme.primaryColor,
    fontFamily: fontFamily,
    // backgroundColor: lightTheme.background,
    dividerColor: lightTheme.dividerColor,
    hintColor: lightTheme.hintColor,
    bottomAppBarTheme: BottomAppBarTheme(color: lightTheme.primaryColor),
    // bottomAppBarColor: lightTheme.primaryColor,
    cardColor: lightTheme.backgroundContainer,
  );

  late final ThemeData _darkTheme = ThemeData(
    primaryColor: darkTheme.primaryColor,
    fontFamily: fontFamily,
    // backgroundColor: darkTheme.background,
    dividerColor: darkTheme.dividerColor,
    hintColor: darkTheme.hintColor,
    bottomAppBarTheme: BottomAppBarTheme(color: darkTheme.primaryColor),
    // bottomAppBarColor: darkTheme.primaryColor,
    cardColor: darkTheme.backgroundContainer,
  );

  ThemeData getThemeData(ThemeType type) {
    if (type == ThemeType.light) {
      return _lightTheme;
    } else {
      return _darkTheme;
    }
  }

  BaseThemeData getBaseTheme(ThemeType type) {
    if (type == ThemeType.light) {
      return lightTheme;
    } else {
      return darkTheme;
    }
  }
}
