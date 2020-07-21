import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
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
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        context
            .bloc<LoadingStateBloc>()
            .add(ToggleLoading(isLoading: state is ChangePasswordLoading));
        if (state is ChangePasswordSuccess) {
          Navigator.pushReplacementNamed(context, RoutesName.auth);
        }
        if (state is ChangePasswordFailed) {
          _scaffoldKey.currentState
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.transparent,
          elevation: 0,
          leading: BackButton(color: Theme.of(context).colorScheme.onSurface),
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
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (!_formKey.currentState.validate()) return;
                  _forgotModel.updateNewPassword(_newPasswordController.text);
                  context
                      .bloc<ChangePasswordBloc>()
                      .add(ChangePassword(forgotModel: _forgotModel));
                },
                icon: Transform.rotate(
                  angle: math.pi * 1.75,
                  child: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                label: Text(
                  'Change password',
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSecondary,
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
