import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:lily_books/api/api_status.dart';
import 'package:lily_books/routes.dart';
import 'package:lily_books/ui/screens/auth/authentication_cubit.dart';
import 'package:lily_books/ui/screens/auth/hide_password/hide_password_cubit.dart';
import 'package:lily_books/ui/screens/loading_state/loading_state_cubit.dart';
import 'package:lily_books/ui/screens/splash/authorization_cubit.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _loginNameController =
      TextEditingController(text: 'linhdpp28@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(),
        SizedBox(height: 50),
        _buildForm(context),
        SizedBox(height: 32),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildEmailTextField(),
            _buildPasswordTextField(),
            SizedBox(height: 32),
            _buildSignInButton(),
            _buildForgotPassword(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return CubitBuilder<LoadingStateCubit, bool>(
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
                context
                    .cubit<AuthenticationCubit>()
                    .signIn(
                      _loginNameController.text,
                      _passwordController.text,
                    )
                    .listen((resource) {
                  context
                      .cubit<LoadingStateCubit>()
                      .toggleLoading(resource.status == ApiStatus.loading);
                  switch (resource.status) {
                    case ApiStatus.loading:
                      break;
                    case ApiStatus.success:
                      context.cubit<AuthorizationCubit>().signIn();
                      break;
                    case ApiStatus.failed:
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text(resource.message)));
                      break;
                  }
                });
              },
              icon: Icon(
                Icons.chevron_right,
                size: 35,
                color: Colors.white,
              ),
              label: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }

  Widget _buildForgotPassword(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, RoutesName.forgot);
      },
      child: Text('Forgot Password'),
    );
  }

  Widget _buildPasswordTextField() {
    return CubitBuilder<HidePasswordCubit, bool>(
      builder: (context, hidePassword) => TextFormField(
        obscureText: hidePassword,
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: GestureDetector(
            child: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
            onTap: () => context.cubit<HidePasswordCubit>().togglePassword(),
          ),
        ),
        validator: (text) {
          if (text.isEmpty) {
            return 'Password is empty';
          }
          if (text.length < 6) {
            return 'Password must be longer than 6 characters.';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      autofocus: true,
      controller: _loginNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Username/Email',
        prefixIcon: Icon(Icons.alternate_email),
      ),
      validator: (text) {
        if (text.isEmpty) {
          return 'Username/Email is empty';
        }
        return null;
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        'Welcome\nback',
        style: TextStyle(
          fontSize: 35,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
