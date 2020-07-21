class ForgotModel {
  String email;
  String code;
  String newPassword;

  String errorMessage;

  ForgotModel({this.email, this.code, this.newPassword, this.errorMessage});

  factory ForgotModel.fromJson(Map<String, dynamic> json) => ForgotModel(
        code: json['code'],
        email: json['email'],
      );

  factory ForgotModel.error(String message) =>
      ForgotModel(errorMessage: message);

  Map<String, dynamic> toJson() => {
        "email": this.email,
        "newPassword": this.newPassword,
      };

  void updateNewPassword(String newPassword) {
    this.newPassword = newPassword;
  }

  void updateCode(String newCode) {
    this.code = newCode;
  }
}
