part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Authorized extends AuthenticationState {}

class Unauthorized extends AuthenticationState {}
