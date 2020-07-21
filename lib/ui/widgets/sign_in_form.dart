import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/bloc/sign_in/sign_in_bloc.dart';
import 'package:lily_books/generated/l10n.dart';
import 'package:lily_books/routes.dart';

class SignInForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _loginNameController =
      TextEditingController(text: 'linhdpp28@gmail.com');
  final TextEditingController _passwordController =
      TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        context
            .bloc<LoadingStateBloc>()
            .add(ToggleLoading(isLoading: state is SignInLoading));
        if (state is SignInFailed) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(context),
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
            _buildEmailTextField(context),
            _buildPasswordTextField(context),
            SizedBox(height: 32),
            _buildSignInButton(),
            _buildForgotPassword(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return BlocBuilder<LoadingStateBloc, bool>(
      builder: (context, loading) => loading
          ? CircularProgressIndicator()
          : RaisedButton.icon(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 32,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                if (!_formKey.currentState.validate()) return;
                context.bloc<SignInBloc>().add(
                      SignIn(
                        loginName: _loginNameController.text,
                        password: _passwordController.text,
                      ),
                    );
              },
              icon: Icon(
                Icons.chevron_right,
                size: 35,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
              label: Text(
                S.of(context).signInAction,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondary,
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
      child: Text(S.of(context).signInActionForgot),
    );
  }

  Widget _buildPasswordTextField(BuildContext context) {
    return BlocBuilder<HidePasswordBloc, bool>(
      builder: (context, hidePassword) => TextFormField(
        obscureText: hidePassword,
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: S.of(context).signInPassword,
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

  Widget _buildEmailTextField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: _loginNameController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: S.of(context).signInUsernameEmail,
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

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        S.of(context).signInMessage,
        style: TextStyle(
          fontSize: 35,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
