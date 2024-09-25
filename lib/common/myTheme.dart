import 'package:fixit/common/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyTheme{
  static final  darkTheme=ThemeData(
    scaffoldBackgroundColor: ColorConstants.scaffoldDark,
    fontFamily:'Work Sans',
    appBarTheme:const AppBarTheme(
      color: ColorConstants.scaffoldDark,
    ) ,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: ColorConstants.primaryColor,
      secondary:ColorConstants.buttonColorLight,
      primaryContainer:ColorConstants.selectedContainerDark,
      onPrimaryContainer:ColorConstants.unSelectedContainerLight,
      tertiary:  ColorConstants.headerTextDark,
      onTertiary:ColorConstants.subheadingTextDark,
      error:ColorConstants.hintTextDark,
      errorContainer: ColorConstants.containerTextLight,
    ),
  );


  static final  lightTheme=ThemeData(
    scaffoldBackgroundColor: ColorConstants.scaffoldLight,
    fontFamily:'Work Sans',
    appBarTheme:const AppBarTheme(
      color: ColorConstants.scaffoldLight,
    ) ,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: ColorConstants.primaryColor,
      secondary:ColorConstants.buttonColorDark,
      primaryContainer:ColorConstants.unSelectedContainerLight,
      onPrimaryContainer:ColorConstants.unSelectedContainerDark,
      tertiary:  ColorConstants.headerTextLight,
      onTertiary:ColorConstants.subheadingTextLight,
      error:ColorConstants.hintTextLight,
      errorContainer: ColorConstants.containerTextDark,
    ),
  );
}

class ThemeController extends GetxController{
  var themeMode=ThemeMode.dark.obs;
  final String themeModeKey = 'theme_mode_key';
  @override
  void onInit() {
    super.onInit();
    loadSavedThemeMode();
  }

  Future<void> loadSavedThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(themeModeKey);
    if (savedMode != null) {
      themeMode.value = (savedMode == 'dark') ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void toggleTheme() {
    themeMode.value = (themeMode.value == ThemeMode.light)
        ? ThemeMode.dark
        : ThemeMode.light;
    _saveThemeMode();
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(themeModeKey, themeMode.value.toString().split('.').last);
  }

  ThemeMode getThemeMode() {
    return themeMode.value;
  }

}