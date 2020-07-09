import 'package:flutter/widgets.dart';

enum AuthScreenType { SignIn, SignUp }

class AuthScreen {
  final AuthScreenType type;
  final String title;

  AuthScreen({@required this.type, @required this.title});
}

var authMenu = [
  AuthScreen(type: AuthScreenType.SignIn, title: 'Sign In'),
  AuthScreen(type: AuthScreenType.SignUp, title: 'Sign Up'),
];
