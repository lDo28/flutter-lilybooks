import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lily_books/routes.dart';

class LilyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lily Books',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: onGenerateRoutes,
    );
  }
}
