import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lily_books/models/forgot.model.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:meta/meta.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(this.authRepo) : super(ChangePasswordInitial());

  final AuthRepo authRepo;

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is ChangePassword) {
      yield ChangePasswordLoading();
      var error = await authRepo.changePassword(event.forgotModel);
      if (error != null) {
        yield ChangePasswordFailed(message: error);
        return;
      }
      yield ChangePasswordSuccess();
    }
  }
}
