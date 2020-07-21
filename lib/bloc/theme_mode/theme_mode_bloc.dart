import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lily_books/constants.dart';
import 'package:meta/meta.dart';

part 'theme_mode_event.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvent, ThemeMode> {
  static final Box<dynamic> _hiveBox = Hive.box(BOX_CONFIG);

  ThemeModeBloc()
      : super(ThemeMode.values[_hiveBox.get(
          BOX_KEY_THEME_MODE,
          defaultValue: 0,
        )]);

  @override
  Stream<ThemeMode> mapEventToState(
    ThemeModeEvent event,
  ) async* {
    if (event is ChangeThemeMode) {
      _hiveBox.put(BOX_KEY_THEME_MODE, event.mode.index);
      yield event.mode;
    }
  }
}
