part of 'auth_type_bloc.dart';

@immutable
abstract class AuthTypeEvent {}

class AuthTypeChange extends AuthTypeEvent {
  final AuthScreenType type;

  AuthTypeChange({this.type});
}
