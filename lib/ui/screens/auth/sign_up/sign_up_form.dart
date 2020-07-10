import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lily_books/api/requests/sign_up.request.dart';
import 'package:lily_books/bloc/authentication/authentication_bloc.dart';
import 'package:lily_books/bloc/hide_password/hide_password_bloc.dart';
import 'package:lily_books/bloc/loading_state/loading_state_bloc.dart';

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController =
      TextEditingController(text: 'Linh Do');
  final TextEditingController _usernameController =
      TextEditingController(text: 'linhdpp28');
  final TextEditingController _emailController =
      TextEditingController(text: 'linhdpp28@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          SizedBox(height: 50),
          _buildForm(context),
          SizedBox(height: 32),
        ],
      ),
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
            _buildDisplayNameTextField(),
            _buildUsernameTextField(),
            _buildEmailTextField(),
            _buildPasswordTextField(),
            SizedBox(height: 32),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return BlocBuilder<HidePasswordBloc, bool>(
      builder: (context, hidePassword) => TextFormField(
        obscureText: hidePassword,
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: GestureDetector(
            child: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
            onTap: () => context.bloc<HidePasswordBloc>().add(TogglePassword()),
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

  Widget _buildUsernameTextField() {
    return TextFormField(
      autofocus: true,
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
        prefixIcon: Icon(Icons.supervised_user_circle),
      ),
      validator: (text) {
        if (text.isEmpty) {
          return 'Username is empty';
        }
        return null;
      },
    );
  }

  Widget _buildDisplayNameTextField() {
    return TextFormField(
      autofocus: true,
      controller: _nameController,
      decoration: InputDecoration(
        labelText: 'Display Name',
        prefixIcon: Icon(Icons.person_outline),
      ),
      validator: (text) {
        if (text.isEmpty) {
          return 'Display Name is empty';
        }
        return null;
      },
    );
  }

  Widget _buildSignUpButton() {
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
                      SignUp(
                        request: SignUpRequest(
                          displayName: _nameController.text,
                          username: _usernameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      ),
                    );
              },
              icon: Icon(
                Icons.chevron_right,
                size: 35,
                color: Colors.white,
              ),
              label: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        'Create\naccount',
        style: TextStyle(
          fontSize: 35,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
