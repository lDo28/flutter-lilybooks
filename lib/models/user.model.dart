import 'package:hive/hive.dart';
import 'package:lily_books/api/responses/user.response.dart';

part 'user.model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String username;
  @HiveField(2)
  String name;
  @HiveField(3)
  String email;
  @HiveField(4)
  bool isAdmin;
  @HiveField(5)
  String token;

  User();

  factory User.copyFrom(UserResponse response) => User()
    ..userId = response.userId
    ..username = response.username
    ..name = response.name
    ..email = response.email
    ..isAdmin = response.isAdmin
    ..token = response.token;
}
