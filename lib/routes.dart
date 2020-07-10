import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/ui/screens/auth/authentication.screen.dart';
import 'package:lily_books/ui/screens/auth/authentication_cubit.dart';
import 'package:lily_books/ui/screens/auth/forgot_password/forgot_password.screen.dart';
import 'package:lily_books/ui/screens/auth/forgot_password/forgot_password_change_password.screen.dart';
import 'package:lily_books/ui/screens/auth/forgot_password/forgot_password_pin.screen.dart';
import 'package:lily_books/ui/screens/home/home.screen.dart';
import 'package:lily_books/ui/screens/home/home_cubit.dart';
import 'package:lily_books/ui/screens/splash/splash.screen.dart';

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
      return _getPageRoute(CubitProvider(
        create: (_) => AuthenticationCubit(),
        child: AuthenticationScreen(),
      ));
    case RoutesName.home:
      return _getPageRoute(CubitProvider(
        create: (_) => HomeCubit(),
        child: HomeScreen(),
      ));
    case RoutesName.forgot:
      return _getPageRoute(CubitProvider(
        create: (_) => AuthenticationCubit(),
        child: ForgotScreen(),
      ));
    case RoutesName.forgotPin:
      return _getPageRoute(CubitProvider(
          create: (_) => AuthenticationCubit(),
          child: ForgotPinScreen(model: settings.arguments)));
    case RoutesName.forgotChangePassword:
      return _getPageRoute(CubitProvider(
          create: (_) => AuthenticationCubit(),
          child: ForgotChangePasswordScreen(model: settings.arguments)));
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
