import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'userModel.g.dart';


@HiveType(typeId: 2)
class UserModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String passwordHash;

  @HiveField(3)
  int role;

  UserModel({
    String? id,
    required this.username,
    required this.passwordHash,
    required this.role,
  }) : this.id = id ?? const Uuid().v4();
}