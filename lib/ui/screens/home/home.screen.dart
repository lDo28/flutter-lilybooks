import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/constants.dart';
import 'package:lily_books/generated/l10n.dart';
import 'package:lily_books/models/user.model.dart';
import 'package:lily_books/routes.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Hive.box(BOX_USER).getAt(0);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is Unauthorized) {
          Navigator.pushReplacementNamed(context, RoutesName.auth);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).appName),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(user.username ?? ''),
                accountEmail: Text(user.email ?? ''),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(S.of(context).drawerSettings),
                onTap: () {
                  Navigator.popAndPushNamed(context, RoutesName.settings);
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(S.of(context).drawerSignOut),
                onTap: () {
                  context.bloc<AuthenticationBloc>().add(SignedOut());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
