import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgot_countdown_event.dart';

class ForgotCountdownBloc extends Bloc<ForgotCountdownEvent, int> {
  Timer _timer;

  ForgotCountdownBloc() : super(60) {
    add(StartCountdown());
  }

  @override
  Stream<int> mapEventToState(
    ForgotCountdownEvent event,
  ) async* {
    if (event is StartCountdown) {
      if (_timer != null) {
        _timer.cancel();
        _timer = null;
        yield 60;
      }
      _timer = Timer.periodic((Duration(seconds: 1)), (Timer timer) {
        if (state < 1) {
          timer.cancel();
          return;
        }
        add(CountdownUpdate(time: state - 1));
      });
    }
    if (event is CountdownUpdate) {
      yield event.time;
    }
    if (event is StopCountdown) {
      _timer?.cancel();
      yield 0;
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
