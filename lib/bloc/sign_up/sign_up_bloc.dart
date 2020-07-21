import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lily_books/api/requests/sign_up.request.dart';
import 'package:lily_books/bloc/blocs.dart';
import 'package:lily_books/models/auth_screen.model.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({this.authTypeBloc, this.authRepo})
      : assert(authTypeBloc != null),
        assert(authRepo != null),
        super(SignUpInitial());

  final AuthRepo authRepo;
  final AuthTypeBloc authTypeBloc;

  @override
  Stream<SignUpState> mapEventToState(
    SignUpEvent event,
  ) async* {
    if (event is SignUp) {
      yield SignUpLoading();
      var error = await authRepo.signUp(SignUpRequest(
        displayName: event.displayName,
        username: event.username,
        email: event.email,
        password: event.password,
      ));
      if (error != null) {
        yield SignUpFailed(message: error);
        return;
      }
      authTypeBloc.add(AuthTypeChange(type: AuthScreenType.SignIn));
      yield SignUpSuccess();
    }
  }
}
