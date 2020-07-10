part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class InitialApp extends AuthenticationEvent {}

class SignIn extends AuthenticationEvent {
  final SignInRequest request;

  SignIn({@required this.request});
}

class SignInListen extends AuthenticationEvent {
  final Resource<bool> resource;

  SignInListen({@required this.resource});
}

class SignUp extends AuthenticationEvent {
  final SignUpRequest request;

  SignUp({@required this.request});
}

class SignUpListen extends AuthenticationEvent {
  final Resource<bool> resource;

  SignUpListen({@required this.resource});
}

class Forgot extends AuthenticationEvent {
  final String email;

  Forgot({@required this.email});
}

class ForgotListen extends AuthenticationEvent {
  final Resource<ForgotModel> resource;

  ForgotListen({@required this.resource});
}

class ChangePassword extends AuthenticationEvent {
  final ForgotModel forgotModel;

  ChangePassword({@required this.forgotModel});
}

class ChangePasswordListen extends AuthenticationEvent {
  final Resource<bool> resource;

  ChangePasswordListen({@required this.resource});
}

class SignOut extends AuthenticationEvent {}
