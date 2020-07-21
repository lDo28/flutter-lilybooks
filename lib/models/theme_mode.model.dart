import 'package:flutter/material.dart';
import 'package:lily_books/generated/l10n.dart';

class ThemeModeModel {
  final ThemeMode mode;
  final String title;

  ThemeModeModel({@required this.mode, @required this.title});
}

List<ThemeModeModel> getThemeModes(BuildContext context) => [
      ThemeModeModel(
          mode: ThemeMode.system, title: S.of(context).settingThemeModeAuto),
      ThemeModeModel(
          mode: ThemeMode.light, title: S.of(context).settingThemeModeLight),
      ThemeModeModel(
          mode: ThemeMode.dark, title: S.of(context).settingThemeModeDark),
    ];
