import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/ui/screens/screens.dart';

class RoutesName {
  static const splash = "/";
  static const auth = "/auth";
  static const home = "/home";
  static const forgot = "/forgot";
  static const forgotPin = "/forgotPin";
  static const forgotChangePassword = "/forgotChangePassword";
}

PageRoute<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case RoutesName.splash:
      return _getPageRoute(SplashScreen());
    case RoutesName.auth:
      return _getPageRoute(
        BlocProvider(
          create: (_) => AuthTypeBloc(),
          child: AuthenticationScreen(),
        ),
      );
    case RoutesName.home:
      return _getPageRoute(HomeScreen());
    case RoutesName.forgot:
      return _getPageRoute(ForgotScreen());
    case RoutesName.forgotPin:
      return _getPageRoute(
        BlocProvider(
          create: (_) => ForgotCountdownBloc(),
          child: ForgotPinScreen(model: settings.arguments),
        ),
      );
    case RoutesName.forgotChangePassword:
      return _getPageRoute(
        ForgotChangePasswordScreen(model: settings.arguments),
      );
    default:
      return _getPageRoute(
        Scaffold(
          body: Center(
            child: Text(
              'Routes not found',
              style: TextStyle(fontSize: 50),
            ),
          ),
        ),
      );
  }
}

PageRoute<dynamic> _getPageRoute(Widget child) {
  if (Platform.isIOS) return CupertinoPageRoute(builder: (_) => child);
  return MaterialPageRoute(builder: (_) => child);
}
