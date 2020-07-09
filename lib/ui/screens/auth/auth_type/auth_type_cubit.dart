import 'package:cubit/cubit.dart';
import 'package:lily_books/models/auth_screen.model.dart';

class AuthTypeCubit extends Cubit<AuthScreenType> {
  AuthTypeCubit() : super(AuthScreenType.SignIn);

  changeType(AuthScreenType type) => emit(type);
}
