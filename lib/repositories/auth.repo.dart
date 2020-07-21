import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:lily_books/api/requests/sign_in.request.dart';
import 'package:lily_books/api/requests/sign_up.request.dart';
import 'package:lily_books/api/responses/lily.response.dart';
import 'package:lily_books/api/responses/user.response.dart';
import 'package:lily_books/constants.dart';
import 'package:lily_books/models/forgot.model.dart';
import 'package:lily_books/models/user.model.dart';
import 'package:lily_books/repositories/base.repo.dart';

class AuthRepo extends BaseRepo {
  Box<dynamic> get userBox => Hive.box(BOX_USER);

  bool get isSignedIn => userBox.isNotEmpty && userBox.getAt(0) != null;

  Future<String> signIn(SignInRequest request) async {
    try {
      var response = await dio.post('users/login', data: request.toJson());
      UserResponse user = UserResponse.fromJson(response.data);
      userBox.add(User.copyFrom(user));
      return null;
    } catch (e) {
      if (e is DioError) {
        var error = LilyResponse.fromJson(e.response.data);
        return error.message;
      }
      return e;
    }
  }

  Future<String> signUp(SignUpRequest request) async {
    try {
      await dio.post('users/register', data: request.toJson());
      return null;
    } catch (e) {
      if (e is DioError) {
        var error = LilyResponse.fromJson(e.response.data);
        return error.message;
      }
      return e;
    }
  }

  Future<ForgotModel> forgot(String email) async {
    try {
      var response = await dio.get(
        'users/forgot',
        queryParameters: {"email": email},
      );
      return ForgotModel.fromJson(response.data);
    } catch (e) {
      if (e is DioError) {
        var error = LilyResponse.fromJson(e.response.data);
        return ForgotModel.error(error.message);
      }
      return ForgotModel.error(e);
    }
  }

  Future<String> changePassword(ForgotModel forgotModel) async {
    try {
      await dio.put('users/forgot/password', data: forgotModel.toJson());
      return null;
    } catch (e) {
      if (e is DioError) {
        var error = LilyResponse.fromJson(e.response.data);
        return error.message;
      }
      return e;
    }
  }

  Future<void> signOut() async {
    await userBox.clear();
  }
}
