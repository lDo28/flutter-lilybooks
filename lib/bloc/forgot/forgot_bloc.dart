import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lily_books/models/forgot.model.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:meta/meta.dart';

part 'forgot_event.dart';

part 'forgot_state.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  ForgotBloc(this.authRepo) : super(ForgotInitial());

  final AuthRepo authRepo;

  @override
  Stream<ForgotState> mapEventToState(
    ForgotEvent event,
  ) async* {
    if (event is Forgot) {
      yield ForgotLoading();
      var forgotModel = await authRepo.forgot(event.email);
      if (forgotModel.errorMessage?.isNotEmpty ?? false) {
        yield ForgotFailed(message: forgotModel.errorMessage);
        return;
      }
      yield ForgotSuccess(forgotModel: forgotModel);
    }
  }
}
