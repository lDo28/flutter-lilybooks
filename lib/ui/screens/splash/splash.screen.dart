import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/ui/screens/splash/authorization_cubit.dart';
import 'package:lily_books/ui/widgets/logo.widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CubitListener<AuthorizationCubit, AuthorizationState>(
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
