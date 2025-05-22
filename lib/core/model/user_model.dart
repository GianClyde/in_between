import 'package:hive/hive.dart';
import 'package:in_between/core/domain/user_entity.dart';

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

  @HiveField(5)
  double credits;

  UserModel({
    required this.username,
    required this.password,
    required this.name,
    required this.mobile,
    required this.bdate,
    required this.credits,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      username: entity.username,
      password: entity.password,
      name: entity.name,
      mobile: entity.mobile,
      bdate: entity.bdate,
      credits: entity.credits,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      username: username,
      password: password,
      name: name,
      mobile: mobile,
      bdate: bdate,
      credits: credits,
    );
  }
}
