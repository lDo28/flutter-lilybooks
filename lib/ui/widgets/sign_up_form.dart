import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/bloc/sign_up/sign_up_bloc.dart';
import 'package:lily_books/extensions/string.exts.dart';
import 'package:lily_books/generated/l10n.dart';

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
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        context
            .bloc<LoadingStateBloc>()
            .add(ToggleLoading(isLoading: state is SignUpLoading));
        if (state is SignUpFailed) {
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
            _buildDisplayNameTextField(context),
            _buildUsernameTextField(context),
            _buildEmailTextField(context),
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
          labelText: S.of(context).signUpPassword,
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
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: S.of(context).signUpEmail,
        prefixIcon: Icon(Icons.alternate_email),
      ),
      validator: (text) {
        if (text.isEmpty) {
          return 'Email is empty';
        }
        if (!text.emailValid()) {
          return 'Wrong email format';
        }
        return null;
      },
    );
  }

  Widget _buildUsernameTextField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: _usernameController,
      decoration: InputDecoration(
        labelText: S.of(context).signUpUsername,
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

  Widget _buildDisplayNameTextField(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: _nameController,
      decoration: InputDecoration(
        labelText: S.of(context).signUpDisplayName,
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
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                if (!_formKey.currentState.validate()) return;
                context.bloc<SignUpBloc>().add(
                      SignUp(
                        displayName: _nameController.text,
                        username: _usernameController.text,
                        email: _emailController.text,
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
                S.of(context).signUpAction,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        S.of(context).signUpMessage,
        style: TextStyle(
          fontSize: 35,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
