import 'package:cubit/cubit.dart';

class LoggerObserver extends CubitObserver {
  @override
  void onTransition(Cubit cubit, Transition transition) {
    print(transition);
    super.onTransition(cubit, transition);
  }
}
