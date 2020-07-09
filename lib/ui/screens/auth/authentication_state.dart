part of 'authentication_cubit.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class SignedIn extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class ForgotPassword extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class ErrorState extends AuthenticationState {
  final Exception error;

  ErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
