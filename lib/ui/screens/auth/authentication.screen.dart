import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/models/auth_screen.model.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/ui/widgets/widgets.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AuthenticationScreen extends StatelessWidget {
  _getForm(AuthScreenType type) {
    switch (type) {
      case AuthScreenType.SignIn:
        return BlocProvider(
          create: (context) => SignInBloc(
            authBloc: context.bloc<AuthenticationBloc>(),
            authRepo: context.repository<AuthRepo>(),
          ),
          child: SignInForm(),
        );
      case AuthScreenType.SignUp:
        return BlocProvider(
          create: (context) => SignUpBloc(
            authTypeBloc: context.bloc<AuthTypeBloc>(),
            authRepo: context.repository<AuthRepo>(),
          ),
          child: SignUpForm(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is Authorized) {
              Navigator.pushReplacementNamed(context, RoutesName.home);
            }
          },
          child: BlocBuilder<AuthTypeBloc, AuthScreenType>(
            builder: (context, type) => ListView(
              children: [
                _buildTabMenu(context, type),
                _getForm(type),
                _buildLanguage(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () => context
              .bloc<LanguageBloc>()
              .add(ChangeLanguage(languageCode: 'en')),
          child: WebsafeSvg.asset(
            'assets/icons/flag_us.svg',
            width: 50,
            height: 50,
          ),
        ),
        SizedBox(width: 16),
        GestureDetector(
          onTap: () => context
              .bloc<LanguageBloc>()
              .add(ChangeLanguage(languageCode: 'vi')),
          child: WebsafeSvg.asset(
            'assets/icons/flag_vn.svg',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildTabMenu(BuildContext context, AuthScreenType type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: getAuthMenu(context)
          .map((item) => AuthTabWidget(item: item, type: type))
          .toList(),
    );
  }
}
