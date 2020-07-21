import 'package:flutter/material.dart';

class ThemeModeModel {
  final ThemeMode mode;
  final String title;

  ThemeModeModel({@required this.mode, @required this.title});
}

var themeModes = [
  ThemeModeModel(mode: ThemeMode.system, title: 'System'),
  ThemeModeModel(mode: ThemeMode.light, title: 'Light'),
  ThemeModeModel(mode: ThemeMode.dark, title: 'Dark'),
];
