import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/ui/widgets/widgets.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is Authorized) {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, RoutesName.home);
            });
          }
          if (state is Unauthorized) {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, RoutesName.auth);
            });
          }
        },
        child: Logo(),
      ),
    );
  }
}
