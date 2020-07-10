import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'hide_password_event.dart';

class HidePasswordBloc extends Bloc<HidePasswordEvent, bool> {
  HidePasswordBloc() : super(true);

  @override
  Stream<bool> mapEventToState(
    HidePasswordEvent event,
  ) async* {
    if (event is TogglePassword) yield !state;
  }
}
