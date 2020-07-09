import 'package:flutter/widgets.dart';

class SignUpRequest {
  final String displayName;
  final String username;
  final String email;
  final String password;

  SignUpRequest({
    @required this.displayName,
    @required this.username,
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toJson() => {
        "displayName": this.displayName,
        "username": this.username,
        "email": this.email,
        "password": this.password,
      };
}
