import 'package:flutter/widgets.dart';
import 'package:lily_books/generated/l10n.dart';

enum AuthScreenType { SignIn, SignUp }

class AuthScreen {
  final AuthScreenType type;
  final String title;

  AuthScreen({@required this.type, @required this.title});
}

List<AuthScreen> getAuthMenu(BuildContext context) => [
      AuthScreen(
          type: AuthScreenType.SignIn, title: S.of(context).authActionSignIn),
      AuthScreen(
          type: AuthScreenType.SignUp, title: S.of(context).authActionSignUp),
    ];
