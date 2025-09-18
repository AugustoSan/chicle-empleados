import 'package:hive/hive.dart';

part 'authModel.g.dart';


@HiveType(typeId: 0)
class AuthModel extends HiveObject {

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String role;

  AuthModel({
    required this.username,
    required this.password,
    required this.role,
  });
}