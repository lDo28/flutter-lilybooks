part of 'forgot_countdown_bloc.dart';

@immutable
abstract class ForgotCountdownEvent {}

class StartCountdown extends ForgotCountdownEvent {}

class CountdownUpdate extends ForgotCountdownEvent {
  final int time;

  CountdownUpdate({this.time});
}

class StopCountdown extends ForgotCountdownEvent {}
