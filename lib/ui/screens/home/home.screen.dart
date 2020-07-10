import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/ui/screens/splash/authorization_cubit.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CubitListener<AuthorizationCubit, AuthorizationState>(
      listener: (context, state) {
        if (state is Unauthorized) {
          Navigator.pushReplacementNamed(context, RoutesName.auth);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign out'),
                onTap: () {
                  context.cubit<AuthorizationCubit>().signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
