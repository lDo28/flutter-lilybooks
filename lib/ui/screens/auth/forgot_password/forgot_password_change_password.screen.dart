import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lily_books/api/api_status.dart';
import 'package:lily_books/bloc/authentication/authentication_bloc.dart';
import 'package:lily_books/bloc/hide_password/hide_password_bloc.dart';
import 'package:lily_books/bloc/loading_state/loading_state_bloc.dart';
import 'package:lily_books/models/forgot.model.dart';
import 'package:lily_books/routes.dart';

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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is ChangePasswordListener) {
          context.bloc<LoadingStateBloc>().add(
                ToggleLoading(
                  isLoading: state.resource.status == ApiStatus.loading,
                ),
              );
          switch (state.resource.status) {
            case ApiStatus.loading:
              break;
            case ApiStatus.success:
              Navigator.pushReplacementNamed(context, RoutesName.auth);
              break;
            case ApiStatus.failed:
              _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text(state.resource.message)));
              break;
          }
        }
      },
      child: Scaffold(
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
            _buildPasswordTextField(),
            SizedBox(height: 16),
            _buildChangePasswordButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePasswordButton() {
    return BlocBuilder<LoadingStateBloc, bool>(builder: (context, loading) {
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
                      .bloc<AuthenticationBloc>()
                      .add(ChangePassword(forgotModel: _forgotModel));
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

  Widget _buildPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: BlocBuilder<HidePasswordBloc, bool>(
        builder: (context, hidePassword) => Form(
          key: _formKey,
          child: TextFormField(
            autofocus: true,
            obscureText: hidePassword,
            controller: _newPasswordController,
            decoration: InputDecoration(
              labelText: 'New Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: GestureDetector(
                child: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off),
                onTap: () =>
                    context.bloc<HidePasswordBloc>().add(TogglePassword()),
              ),
            ),
            validator: (text) {
              if (text.isEmpty) return 'New Password is empty!';
              if (text.length < 6) {
                return 'New Password must be longer than 6 characters.';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
