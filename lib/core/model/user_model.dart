import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @HiveField(2)
  String name;

  @HiveField(3)
  String mobile;

  @HiveField(4)
  String bdate;

  UserModel({
    required this.username,
    required this.password,
    required this.name,
    required this.mobile,
    required this.bdate,
  });
}
