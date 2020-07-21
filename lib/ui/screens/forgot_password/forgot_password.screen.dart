import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/extensions/string.exts.dart';
import 'package:lily_books/routes.dart';

class ForgotScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController =
      TextEditingController(text: 'linhdpp28@gmail.com');
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotBloc, ForgotState>(
      listener: (context, state) {
        context
            .bloc<LoadingStateBloc>()
            .add(ToggleLoading(isLoading: state is ForgotLoading));

        if (state is ForgotSuccess) {
          Navigator.pushReplacementNamed(
            context,
            RoutesName.forgotPin,
            arguments: state.forgotModel,
          );
        }
        if (state is ForgotFailed) {
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
                vertical: 16,
                horizontal: 32,
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                if (!_formKey.currentState.validate()) return;
                context
                    .bloc<ForgotBloc>()
                    .add(Forgot(email: _emailController.text));
              },
              icon: Transform.rotate(
                angle: math.pi * 1.75,
                child: Icon(
                  Icons.send,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              label: Text(
                'Send email',
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondary,
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
        if (!text.emailValid()) {
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
