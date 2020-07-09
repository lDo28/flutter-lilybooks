part of 'authorization_cubit.dart';

abstract class AuthorizationState extends Equatable {
  const AuthorizationState();
}

class AuthInitial extends AuthorizationState {
  @override
  List<Object> get props => [];
}

class Authorized extends AuthorizationState {
  @override
  List<Object> get props => [];
}

class Unauthorized extends AuthorizationState {
  @override
  List<Object> get props => [];
}

class ErrorState extends AuthorizationState {
  final Exception error;

  ErrorState({@required this.error});

  @override
  List<Object> get props => [error];
}
