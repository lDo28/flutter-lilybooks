part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Authorized extends AuthenticationState {}

class SignedInListener extends AuthenticationState {
  final Resource<bool> resource;

  SignedInListener({@required this.resource});
}

class SignedUpListener extends AuthenticationState {
  final Resource<bool> resource;

  SignedUpListener({@required this.resource});
}

class ForgotListener extends AuthenticationState {
  final Resource<ForgotModel> resource;

  ForgotListener({@required this.resource});
}

class ChangePasswordListener extends AuthenticationState {
  final Resource<bool> resource;

  ChangePasswordListener({@required this.resource});
}

class Unauthorized extends AuthenticationState {}
