import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/bloc/authentication/authentication_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
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
                  context.bloc<AuthenticationBloc>().add(SignOut());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
