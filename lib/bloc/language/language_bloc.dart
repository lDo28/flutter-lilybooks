import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:lily_books/constants.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, String> {
  static final Box<dynamic> _hiveBox = Hive.box(BOX_CONFIG);
  static final String _currentLocale = Intl.getCurrentLocale();

  LanguageBloc()
      : super(_hiveBox.get(BOX_KEY_LANGUAGE,
            defaultValue: _currentLocale.substring(
                0, _currentLocale.indexOf('_') ?? _currentLocale.length)));

  @override
  Stream<String> mapEventToState(
    LanguageEvent event,
  ) async* {
    if (event is ChangeLanguage) {
      _hiveBox.put(BOX_KEY_LANGUAGE, event.languageCode);
      yield event.languageCode;
    }
  }
}
