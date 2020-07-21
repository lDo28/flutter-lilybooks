part of 'forgot_bloc.dart';

@immutable
abstract class ForgotState {}

class ForgotInitial extends ForgotState {}

class ForgotLoading extends ForgotState {}

class ForgotSuccess extends ForgotState {
  final ForgotModel forgotModel;

  ForgotSuccess({@required this.forgotModel});
}

class ForgotFailed extends ForgotState {
  final String message;

  ForgotFailed({@required this.message});
}
