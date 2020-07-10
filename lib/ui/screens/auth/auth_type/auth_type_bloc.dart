import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lily_books/models/auth_screen.model.dart';
import 'package:meta/meta.dart';

part 'auth_type_event.dart';

class AuthTypeBloc extends Bloc<AuthTypeEvent, AuthScreenType> {
  AuthTypeBloc() : super(AuthScreenType.SignIn);

  @override
  Stream<AuthScreenType> mapEventToState(
    AuthTypeEvent event,
  ) async* {
    if (event is AuthTypeChange) yield event.type;
  }
}
