import 'dart:async';

import 'package:cubit/cubit.dart';

class ForgotCountdownCubit extends Cubit<int> {
  Timer _timer;

  ForgotCountdownCubit() : super(60) {
    start();
  }

  void start() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      emit(60);
    }
    _timer = Timer.periodic((Duration(seconds: 1)), (Timer timer) {
      if (state < 1) {
        timer.cancel();
        return;
      }
      emit(state - 1);
    });
  }

  void cancel() {
    _timer.cancel();
    emit(0);
  }
}
