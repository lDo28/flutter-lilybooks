part of 'forgot_bloc.dart';

@immutable
abstract class ForgotEvent {}

class Forgot extends ForgotEvent {
  final String email;

  Forgot({@required this.email});
}
