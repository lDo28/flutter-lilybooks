part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class InitialApp extends AuthenticationEvent {}

class SignedIn extends AuthenticationEvent {}

class SignedOut extends AuthenticationEvent {}
