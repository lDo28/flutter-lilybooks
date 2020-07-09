import 'package:cubit/cubit.dart';

class LoadingStateCubit extends Cubit<bool> {
  LoadingStateCubit() : super(false);

  void toggleLoading(bool loading) => emit(loading);
}
