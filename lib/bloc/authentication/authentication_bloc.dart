import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lily_books/api/api_status.dart';
import 'package:lily_books/api/requests/sign_in.request.dart';
import 'package:lily_books/api/requests/sign_up.request.dart';
import 'package:lily_books/models/forgot.model.dart';
import 'package:lily_books/repositories/auth.repo.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepo authRepo;
  StreamSubscription _signInSub, _signUpSub, _forgotSub, _changePasswordSub;

  AuthenticationBloc(this.authRepo) : super(AuthenticationInitial()) {
    add(InitialApp());
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is InitialApp) {
      if (await authRepo.isSignedIn()) {
        yield Authorized();
      } else {
        yield Unauthorized();
      }
    }

    if (event is SignIn) {
      _signInSub = authRepo.signIn(event.request).listen((resource) {
        add(SignInListen(resource: resource));
      });
    }
    if (event is SignInListen) {
      yield SignedInListener(resource: event.resource);
    }

    if (event is SignUp) {
      _signUpSub = authRepo.signUp(event.request).listen((resource) {
        add(SignUpListen(resource: resource));
      });
    }
    if (event is SignUpListen) {
      yield SignedUpListener(resource: event.resource);
    }

    if (event is Forgot) {
      _forgotSub = authRepo.forgot(event.email).listen((resource) {
        add(ForgotListen(resource: resource));
      });
    }
    if (event is ForgotListen) {
      yield ForgotListener(resource: event.resource);
    }

    if (event is ChangePassword) {
      _forgotSub =
          authRepo.changePassword(event.forgotModel).listen((resource) {
        add(ChangePasswordListen(resource: resource));
      });
    }
    if (event is ChangePasswordListen) {
      yield ChangePasswordListener(resource: event.resource);
    }

    if (event is SignOut) {
      authRepo.signOut();
      yield Unauthorized();
    }
  }

  @override
  Future<void> close() {
    _signInSub?.cancel();
    _signUpSub?.cancel();
    _forgotSub?.cancel();
    _changePasswordSub?.cancel();
    return super.close();
  }
}
