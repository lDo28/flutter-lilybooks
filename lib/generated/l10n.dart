// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Lily Books`
  String get appName {
    return Intl.message(
      'Lily Books',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get authActionSignIn {
    return Intl.message(
      'Sign In',
      name: 'authActionSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get authActionSignUp {
    return Intl.message(
      'Sign Up',
      name: 'authActionSignUp',
      desc: '',
      args: [],
    );
  }

  /// `Welcome\nback`
  String get signInMessage {
    return Intl.message(
      'Welcome\nback',
      name: 'signInMessage',
      desc: '',
      args: [],
    );
  }

  /// `Username/Email`
  String get signInUsernameEmail {
    return Intl.message(
      'Username/Email',
      name: 'signInUsernameEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signInPassword {
    return Intl.message(
      'Password',
      name: 'signInPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signInAction {
    return Intl.message(
      'Sign In',
      name: 'signInAction',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get signInActionForgot {
    return Intl.message(
      'Forgot Password?',
      name: 'signInActionForgot',
      desc: '',
      args: [],
    );
  }

  /// `Create\naccount`
  String get signUpMessage {
    return Intl.message(
      'Create\naccount',
      name: 'signUpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Display name`
  String get signUpDisplayName {
    return Intl.message(
      'Display name',
      name: 'signUpDisplayName',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get signUpUsername {
    return Intl.message(
      'Username',
      name: 'signUpUsername',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get signUpEmail {
    return Intl.message(
      'Email',
      name: 'signUpEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get signUpPassword {
    return Intl.message(
      'Password',
      name: 'signUpPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUpAction {
    return Intl.message(
      'Sign Up',
      name: 'signUpAction',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get drawerSettings {
    return Intl.message(
      'Settings',
      name: 'drawerSettings',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get drawerSignOut {
    return Intl.message(
      'Sign out',
      name: 'drawerSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingTitle {
    return Intl.message(
      'Settings',
      name: 'settingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Theme Mode`
  String get settingThemeModeTitle {
    return Intl.message(
      'Theme Mode',
      name: 'settingThemeModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Auto`
  String get settingThemeModeAuto {
    return Intl.message(
      'Auto',
      name: 'settingThemeModeAuto',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get settingThemeModeLight {
    return Intl.message(
      'Light',
      name: 'settingThemeModeLight',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get settingThemeModeDark {
    return Intl.message(
      'Dark',
      name: 'settingThemeModeDark',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get settingLanguageTitle {
    return Intl.message(
      'Language',
      name: 'settingLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get settingLanguageEnglish {
    return Intl.message(
      'English',
      name: 'settingLanguageEnglish',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get settingLanguageVietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'settingLanguageVietnamese',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}