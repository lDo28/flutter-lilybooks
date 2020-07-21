import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:lily_books/ui/screens/screens.dart';

// Routes name for push
class RoutesName {
  static const splash = "/";

  static const auth = "/auth";
  static const forgot = "/forgot";
  static const forgotPin = "/forgotPin";
  static const forgotChangePassword = "/forgotChangePassword";

  static const home = "/home";
  static const settings = "/settings";
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
    case RoutesName.forgot:
      return _getPageRoute(BlocProvider(
          create: (context) => ForgotBloc(context.repository<AuthRepo>()),
          child: ForgotScreen()));
    case RoutesName.forgotPin:
      return _getPageRoute(
        MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) =>
                    ForgotBloc(context.repository<AuthRepo>())),
            BlocProvider(create: (_) => ForgotCountdownBloc()),
          ],
          child: ForgotPinScreen(model: settings.arguments),
        ),
      );
    case RoutesName.forgotChangePassword:
      return _getPageRoute(
        BlocProvider(
            create: (context) =>
                ChangePasswordBloc(context.repository<AuthRepo>()),
            child: ForgotChangePasswordScreen(model: settings.arguments)),
      );

    case RoutesName.home:
      return _getPageRoute(HomeScreen());
    case RoutesName.settings:
      return _getPageRoute(SettingScreen());

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
