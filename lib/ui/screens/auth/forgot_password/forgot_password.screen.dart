import 'dart:math' as math;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lily_books/api/api_status.dart';
import 'package:lily_books/bloc/authentication/authentication_bloc.dart';
import 'package:lily_books/bloc/loading_state/loading_state_bloc.dart';
import 'package:lily_books/routes.dart';

class ForgotScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController =
      TextEditingController(text: 'linhdpp28@gmail.com');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is ForgotListener) {
          context.bloc<LoadingStateBloc>().add(
                ToggleLoading(
                  isLoading: state.resource.status == ApiStatus.loading,
                ),
              );
          switch (state.resource.status) {
            case ApiStatus.loading:
              break;
            case ApiStatus.success:
              Navigator.pushNamed(
                context,
                RoutesName.forgotPin,
                arguments: state.resource.data,
              );
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
            _buildForm(context),
          ],
        ),
      ),
    );
  }

  Padding _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildEmailTextField(),
            SizedBox(height: 32),
            _buildSendEmailButton(),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSendEmailButton() {
    return BlocBuilder<LoadingStateBloc, bool>(
      builder: (context, loading) => loading
          ? CircularProgressIndicator()
          : RaisedButton.icon(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 32,
              ),
              color: Colors.deepPurple,
              onPressed: () async {
                if (!_formKey.currentState.validate()) return;
                context.bloc<AuthenticationBloc>().add(
                      Forgot(email: _emailController.text),
                    );
              },
              icon: Transform.rotate(
                angle: math.pi * 1.75,
                child: Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              label: Text(
                'Send email',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      autofocus: true,
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.alternate_email),
      ),
      validator: (text) {
        if (text.isEmpty) {
          return 'Email is empty';
        }
        if (!EmailValidator.validate(text)) {
          return 'Wrong email format';
        }
        return null;
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        'Reset\npassword',
        style: TextStyle(
          fontSize: 35,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
