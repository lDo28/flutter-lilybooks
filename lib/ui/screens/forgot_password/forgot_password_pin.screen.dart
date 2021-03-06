import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/models/forgot.model.dart';
import 'package:lily_books/routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPinScreen extends StatelessWidget {
  final ForgotModel _forgotModel;
  final TextEditingController _pinController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final StreamController<ErrorAnimationType> _errorController =
      StreamController<ErrorAnimationType>();

  ForgotPinScreen({ForgotModel model})
      : assert(model != null),
        _forgotModel = model;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotBloc, ForgotState>(
      listener: (context, state) {
        context
            .bloc<LoadingStateBloc>()
            .add(ToggleLoading(isLoading: state is ForgotLoading));
        if (state is ForgotSuccess) {
          _forgotModel.updateCode(state.forgotModel.code);
        }
        if (state is ForgotFailed) {
          Scaffold.of(context)
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
        body: BlocBuilder<ForgotCountdownBloc, int>(
          builder: (context, time) => ListView(
            children: [
              _buildHeader(),
              SizedBox(height: 50),
              _buildPinField(context),
              SizedBox(height: 16),
              _buildResendCountdown(context, time)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendCountdown(BuildContext context, int time) {
    return time <= 0
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FlatButton(
              onPressed: () {
                context.bloc<ForgotCountdownBloc>().add(StartCountdown());
                context
                    .bloc<ForgotBloc>()
                    .add(Forgot(email: _forgotModel.email));
              },
              child: Text('Resend email with PIN code',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          )
        : Text(
            'Resend email after $time ${time > 1 ? 'seconds' : 'second'}.',
            textAlign: TextAlign.center,
          );
  }

  Widget _buildPinField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: PinCodeTextField(
        autoFocus: true,
        length: 6,
        controller: _pinController,
        textInputType: TextInputType.number,
        animationType: AnimationType.fade,
        errorAnimationController: _errorController,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.underline,
          fieldHeight: 50,
        ),
        onCompleted: (code) {
          if (code == _forgotModel.code) {
            _errorController.close();
            context.bloc<ForgotCountdownBloc>().add(StopCountdown());
            Navigator.pushReplacementNamed(
              context,
              RoutesName.forgotChangePassword,
              arguments: _forgotModel,
            );
          } else {
            _errorController.add(ErrorAnimationType.shake);
            _scaffoldKey.currentState
                .showSnackBar(SnackBar(content: Text('Wrong PIN Code')));
            _pinController.clear();
          }
        },
        onChanged: (code) {},
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Text(
        'Reset password\nInput PIN',
        style: TextStyle(
          fontSize: 35,
          color: Colors.deepOrange,
        ),
      ),
    );
  }
}
