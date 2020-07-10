part of 'loading_state_bloc.dart';

@immutable
abstract class LoadingStateEvent {}

class ToggleLoading extends LoadingStateEvent {
  final bool isLoading;

  ToggleLoading({@required this.isLoading});
}
