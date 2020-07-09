import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lily_books/api/api_status.dart';
import 'package:lily_books/api/requests/sign_in.request.dart';
import 'package:lily_books/api/requests/sign_up.request.dart';
import 'package:lily_books/repositories/auth.repo.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthRepo _authRepo = new AuthRepo();

  AuthenticationCubit() : super(AuthenticationInitial());

  Stream<Resource<bool>> signIn(String loginName, String password) =>
      _authRepo.signIn(SignInRequest(loginName: loginName, password: password));

  void signedIn() => emit(SignedIn());

  Stream<Resource<bool>> signUp(
    String displayName,
    String username,
    String email,
    String password,
  ) =>
      _authRepo.signUp(SignUpRequest(
        displayName: displayName,
        username: username,
        email: email,
        password: password,
      ));

  Stream<Resource<bool>> forgotPassword(String email) =>
      _authRepo.signUp(SignUpRequest(
        displayName: displayName,
        username: username,
        email: email,
        password: password,
      ));

  void forgotPassword() => emit(ForgotPassword());
}
