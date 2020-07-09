import 'package:cubit/cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lily_books/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authorization_state.dart';

class AuthorizationCubit extends Cubit<AuthorizationState> {
  AuthorizationCubit() : super(AuthInitial()) {
    _initSplash();
  }

  void _initSplash() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey(PREFS_KEY_TOKEN) &&
          prefs.containsKey(PREFS_KEY_USER_ID)) {
        emit(Authorized());
      } else {
        emit(Unauthorized());
      }
    } catch (e) {
      emit(ErrorState(error: e));
    }
  }

  void signIn() => emit(Authorized());

  void signOut() => emit(Unauthorized());
}
