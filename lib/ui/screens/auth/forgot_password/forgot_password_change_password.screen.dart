import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/api/api_status.dart';
import 'package:lily_books/models/forgot.model.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/ui/screens/auth/authentication_cubit.dart';
import 'package:lily_books/ui/screens/loading_state/loading_state_cubit.dart';

class ForgotChangePasswordScreen extends StatelessWidget {
  final ForgotModel _forgotModel;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _newPasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  ForgotChangePasswordScreen({ForgotModel model})
      : assert(model != null),
        _forgotModel = model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Theme.of(context).primaryColor),
      ),
      body: ListView(
        children: [
          _buildHeader(),
          SizedBox(height: 50),
          _buildPinField(context),
          SizedBox(height: 16),
          _buildChangePasswordButton(),
        ],
      ),
    );
  }

  Widget _buildChangePasswordButton() {
    return CubitBuilder<LoadingStateCubit, bool>(builder: (context, loading) {
      return loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: RaisedButton.icon(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 32,
                ),
                color: Colors.deepPurple,
                onPressed: () async {
                  if (!_formKey.currentState.validate()) return;
                  _forgotModel.updateNewPassword(_newPasswordController.text);
                  context
                      .cubit<AuthenticationCubit>()
                      .changePassword(_forgotModel)
                      .listen((resource) {
                    context
                        .cubit<LoadingStateCubit>()
                        .toggleLoading(resource.status == ApiStatus.loading);
                    switch (resource.status) {
                      case ApiStatus.loading:
                        break;
                      case ApiStatus.success:
                        Navigator.pushNamed(context, RoutesName.auth);
                        break;
                      case ApiStatus.failed:
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text(resource.message)));
                        break;
                    }
                  });
                },
                icon: Transform.rotate(
                  angle: pi * 1.75,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
                label: Text(
                  'Change password',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            );
    });
  }

  Padding _buildPinField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Form(
        key: _formKey,
        child: TextFormField(
          autofocus: true,
          controller: _newPasswordController,
          validator: (text) {
            if (text.isEmpty) return 'New Password is empty!';
            if (text.length < 6) {
              return 'New Password must be longer than 6 characters.';
            }
            return null;
          },
          decoration: InputDecoration(
            labelText: 'New Password',
            prefixIcon: Icon(Icons.lock_outline),
          ),
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        'Change\nPassword',
        style: TextStyle(
          fontSize: 35,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
