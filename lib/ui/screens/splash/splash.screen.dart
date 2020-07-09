import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/ui/screens/auth/authentication.screen.dart';
import 'package:lily_books/ui/screens/auth/authentication_cubit.dart';
import 'package:lily_books/ui/screens/home/home.screen.dart';
import 'package:lily_books/ui/screens/home/home_cubit.dart';
import 'package:lily_books/ui/screens/loading_state/loading_state_cubit.dart';
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CubitProvider(
                    create: (_) => HomeCubit(),
                    child: HomeScreen(),
                  ),
                ),
              );
            });
          }
          if (state is Unauthorized) {
            Future.delayed(Duration(milliseconds: 500), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MultiCubitProvider(
                    providers: [
                      CubitProvider(create: (_) => AuthenticationCubit()),
                      CubitProvider(create: (_) => LoadingStateCubit()),
                    ],
                    child: AuthenticationScreen(),
                  ),
                ),
              );
            });
          }
        },
        child: Logo(),
      ),
    );
  }
}
