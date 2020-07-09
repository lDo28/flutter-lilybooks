import 'package:flutter/widgets.dart';

class SignInRequest {
  final String loginName;
  final String password;

  SignInRequest({@required this.loginName, @required this.password});

  Map<String, dynamic> toJson() => {
        "loginName": this.loginName,
        "password": this.password,
      };
}
