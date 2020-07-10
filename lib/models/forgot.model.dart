class ForgotModel {
  String email;
  String code;
  String newPassword;

  ForgotModel({this.email, this.code, this.newPassword});

  factory ForgotModel.fromJson(Map<String, dynamic> json) => ForgotModel(
        code: json['code'],
        email: json['email'],
      );

  void updateNewPassword(String newPassword) {
    this.newPassword = newPassword;
  }

  void updateCode(String newCode) {
    this.code = newCode;
  }
}
