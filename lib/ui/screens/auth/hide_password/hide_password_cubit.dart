import 'package:cubit/cubit.dart';

class HidePasswordCubit extends Cubit<bool> {
  HidePasswordCubit() : super(true);

  void togglePassword() => emit(!state);
}
