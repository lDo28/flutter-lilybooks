part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignIn extends SignInEvent {
  final String loginName, password;

  SignIn({@required this.loginName, @required this.password});
}
