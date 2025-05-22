import 'package:hive/hive.dart';
import 'package:in_between/features/authentication/domain/entities/auth_entity.dart';
part 'auth_model.g.dart';

@HiveType(typeId: 2)
class AuthModel extends HiveObject {
  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  AuthModel({required this.username, required this.password});

  factory AuthModel.fromEntity(Authentication entity) {
    return AuthModel(username: entity.username, password: entity.password);
  }

  Authentication toEntity() {
    return Authentication(username: username, password: password);
  }
}
//UserModel gagamitin di to