import 'package:hive/hive.dart';

part 'authModel.g.dart';


@HiveType(typeId: 0)
class AuthModel extends HiveObject {

  @HiveField(0)
  String username;

  AuthModel({
    required this.username,
  });
}