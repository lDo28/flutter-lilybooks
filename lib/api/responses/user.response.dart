class UserResponse {
  final String userId;
  final String name;
  final String email;
  final bool isAdmin;
  final String token;

  UserResponse({this.userId, this.name, this.email, this.isAdmin, this.token});

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        userId: json['id'],
        name: json['name'],
        email: json['email'],
        isAdmin: json['is_admin'],
        token: json['token'],
      );
}
