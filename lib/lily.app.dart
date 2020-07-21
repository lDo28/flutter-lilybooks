import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/bloc/theme_mode/theme_mode_bloc.dart';
import 'package:lily_books/generated/l10n.dart';
import 'package:lily_books/routes.dart';

class LilyApp extends StatefulWidget {
  @override
  _LilyAppState createState() => _LilyAppState();
}

class _LilyAppState extends State<LilyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, ThemeMode>(
      builder: (_, themeMode) => BlocBuilder<LanguageBloc, String>(
        builder: (_, languageCode) => MaterialApp(
          title: 'Lily Books',
          debugShowCheckedModeBanner: false,
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.deepPurple,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.amber,
            fontFamily: GoogleFonts.montserrat().fontFamily,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          locale: Locale(languageCode),
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            S.delegate
          ],
          initialRoute: RoutesName.splash,
          onGenerateRoute: onGenerateRoutes,
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
