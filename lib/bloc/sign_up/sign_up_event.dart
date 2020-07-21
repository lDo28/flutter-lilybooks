part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUp extends SignUpEvent {
  final String displayName, email, username, password;

  SignUp({
    @required this.displayName,
    @required this.email,
    @required this.username,
    @required this.password,
  });
}
