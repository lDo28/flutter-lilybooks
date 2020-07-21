import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/bloc/theme_mode/theme_mode_bloc.dart';
import 'package:lily_books/generated/l10n.dart';
import 'package:lily_books/models/theme_mode.model.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settingTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildThemeMode(),
            SizedBox(height: 32),
            _buildLanguage(),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguage() {
    return BlocBuilder<LanguageBloc, String>(
      builder: (context, languageCode) => Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.language,
                  size: 50,
                ),
                SizedBox(width: 16),
                Text(
                  S.of(context).settingLanguageTitle,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            DropdownButton(
              value: languageCode,
              isExpanded: true,
              items: [
                DropdownMenuItem(
                  child: Text(
                    S.of(context).settingLanguageEnglish,
                  ),
                  value: 'en',
                ),
                DropdownMenuItem(
                  child: Text(
                    S.of(context).settingLanguageVietnamese,
                  ),
                  value: 'vi',
                ),
              ],
              onChanged: (v) {
                context
                    .bloc<LanguageBloc>()
                    .add(ChangeLanguage(languageCode: v));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeMode() {
    return BlocBuilder<ThemeModeBloc, ThemeMode>(
      builder: (context, mode) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.rotate(
                  angle: mode == ThemeMode.dark ? pi * .75 : 0,
                  child: Icon(
                    mode == ThemeMode.dark
                        ? Icons.brightness_3
                        : mode == ThemeMode.light
                            ? Icons.brightness_5
                            : Icons.brightness_auto,
                    size: 50,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  S.of(context).settingThemeModeTitle,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getThemeModes(context)
                  .map(
                    (theme) => GestureDetector(
                      onTap: () {
                        context
                            .bloc<ThemeModeBloc>()
                            .add(ChangeThemeMode(mode: theme.mode));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        child: Text(
                          theme.title,
                          style: TextStyle(
                            color: theme.mode == mode
                                ? Theme.of(context).colorScheme.onSecondary
                                : Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(.9),
                            fontWeight: theme.mode == mode
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: theme.mode == mode
                              ? Theme.of(context).primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
