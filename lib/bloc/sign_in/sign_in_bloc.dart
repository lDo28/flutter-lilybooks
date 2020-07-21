import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lily_books/api/requests/sign_in.request.dart';
import 'package:lily_books/bloc/authentication/authentication_bloc.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({this.authBloc, this.authRepo})
      : assert(authBloc != null),
        assert(authRepo != null),
        super(SignInInitial());

  final AuthRepo authRepo;
  final AuthenticationBloc authBloc;

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SignIn) {
      yield SignInLoading();
      var error = await authRepo.signIn(SignInRequest(
        loginName: event.loginName,
        password: event.password,
      ));
      if (error != null) {
        yield SignInFailed(message: error);
        return;
      }
      authBloc.add(SignedIn());
      yield SignInSuccess();
    }
  }
}
