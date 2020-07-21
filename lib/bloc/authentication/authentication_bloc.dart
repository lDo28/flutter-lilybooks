import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo authRepo;

  AuthenticationBloc(this.authRepo) : super(AuthenticationInitial()) {
    add(InitialApp());
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is InitialApp) {
      if (authRepo.isSignedIn) {
        yield Authorized();
      } else {
        yield Unauthorized();
      }
    }

    if (event is SignedIn) {
      yield Authorized();
    }
    if (event is SignedOut) {
      authRepo.signOut();
      yield Unauthorized();
    }
  }
}
