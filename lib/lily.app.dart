import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/bloc/theme_mode/theme_mode_bloc.dart';
import 'package:lily_books/routes.dart';

class LilyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, ThemeMode>(
      builder: (context, mode) => MaterialApp(
        title: 'Lily Books',
        debugShowCheckedModeBanner: false,
        themeMode: mode,
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
        initialRoute: RoutesName.splash,
        onGenerateRoute: onGenerateRoutes,
      ),
    );
  }
}
