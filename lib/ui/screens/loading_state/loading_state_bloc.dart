import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'loading_state_event.dart';

class LoadingStateBloc extends Bloc<LoadingStateEvent, bool> {
  LoadingStateBloc() : super(false);

  @override
  Stream<bool> mapEventToState(
    LoadingStateEvent event,
  ) async* {
    if (event is ToggleLoading) {
      yield event.isLoading;
    }
  }
}
